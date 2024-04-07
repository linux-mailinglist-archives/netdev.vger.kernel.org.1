Return-Path: <netdev+bounces-85481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4A89AF45
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 09:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AAE1C2083A
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF4F4E7;
	Sun,  7 Apr 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWJtMVa3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E37484
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476296; cv=none; b=cgxFZzdxjloUgDqHxrkZXIfffFRK3MnDr0iG5MGaAM1uV+qXi4z5Kh7dZBimASGTPGHQghue7DTXJ94Xo94gFYj4ngYlMhOVLlB8IgVwEcCEG/BffNj6EZO/2B4iU+sz4fa3QjMa4S+V5/vWCGi1XAq96zQjV3pEIFQ/gGXIzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476296; c=relaxed/simple;
	bh=qGwEwZLj25vAFcnB+Me4nUXXssA9B9ZYMpRdCunImjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfNvyrhzIy/C3YyyMtMpuXN+2bTHarwT/s3MESOsiqByuyIieYGgi9Fp4g4y6oQhAQOCIh5n52QLvg/izEYVWTF+W99jGo6xQcyIsmiXMEXWYYxlkG5dsIWWZr9fRaA0yOZhqHV2wYw46MU8xIF+20lIt3X99CMI/mM7sA78F1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWJtMVa3; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3554713276.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712476294; x=1713081094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcrJ+f/leZ2llI1AVCg9OHk7bRAhwySZ6SeppuOh+9Y=;
        b=TWJtMVa343xkOuDM5sMS4rbx3viHP5V4t4GfmPWDCQd+QAAbWijZRDgWsGqqXFG6kw
         JuT0ujejR4awZNnzcI25SpYczE+K3mRgnZ6KYsDoERn7fyXssRWv3lJPc71LB8ZdWxGz
         QlbPutwUlPOwOrlJNv6R4/giuJsx0a+f+Coj730t9gGC9G+toFqa25+w8KkAjvg2Daun
         13JR2TGYvVD0S9T+0ImPuZ1lwKOpwtn1mEL6FbeTLkfBjPbDP/VdFwg1P5iXi4o6yVkz
         aENiU6qVdB230ESt2qNTG4sYQqg3m5yj2SpRyeDn/3g7CvzIvlR6qzbAGDqpunbxzGIM
         OBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712476294; x=1713081094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcrJ+f/leZ2llI1AVCg9OHk7bRAhwySZ6SeppuOh+9Y=;
        b=TFLCKpO3Av79aDPaA5qKmC3dg4eC7rpiFED+Jui/tpWSh+f1ipAqJwwh03RbiA2LI3
         zYxjz8eGuWTi10CXJwYq1uESjRk5GTNXxVMSblzfm7xR/YmzcyplmaSrNroftQJNCeMH
         qeNv0iVzEwzcVMTckDr3Tbd8Ipkgyzz+ktjhvQsQhkgr3mKsA9cgsT/kN2EMY/j/LQzG
         fcxhCaYmk8wEy4IJgaRs3oqNFW+ZJpoe+fpRk9Uzfs9a4SVy98IUU0p70hj5loabg1Tx
         qn9lOTaqX9hMvKDRuL9ZISfSpCVqPIvEkNisZkrmZXX8U7eiQbAje8HspcWm1+jo78X2
         vN6w==
X-Gm-Message-State: AOJu0Yzo1u49mDhO6sFoXzfUmVXQ5lcY1RPIvzgseM+2lfKEczzQyRRw
	aT3Q3Tfmm3QzmGkE6PDEzVDYhnoPbuUeOEB/SmwCOy4A2mPNRaUByZJHYsNJmiNyBH2/83lniaR
	/P0dXu2L+F7WDbOQwBU/SZ9uqDa4=
X-Google-Smtp-Source: AGHT+IH+burj7vX37nFGWgMb+ZL2QpP91qPF0sQy9BiVJM9Swp734JvHpmpEKV15DMh1crESLT9H23fhAuKM/pBSzQw=
X-Received: by 2002:a05:6902:2b0d:b0:dcf:f4d3:3a16 with SMTP id
 fi13-20020a0569022b0d00b00dcff4d33a16mr4980429ybb.45.1712476294097; Sun, 07
 Apr 2024 00:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406182107.261472-1-jmaloy@redhat.com> <20240406182107.261472-3-jmaloy@redhat.com>
 <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com> <CAL+tcoC8LBQGe7ES01bxKFkU15GoFpEgT5jx1tnwb2Yb_BOKfw@mail.gmail.com>
In-Reply-To: <CAL+tcoC8LBQGe7ES01bxKFkU15GoFpEgT5jx1tnwb2Yb_BOKfw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 7 Apr 2024 15:51:22 +0800
Message-ID: <CADxym3ZfC5WF7C2B8oYq=38rsLnQ-DOfvhH3iSk6+L0g2=XWDQ@mail.gmail.com>
Subject: Re: [net-next 2/2] tcp: correct handling of extreme menory squeeze
To: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet <edumazet@google.com>, jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, dongmenglong.8@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 2:52=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sun, Apr 7, 2024 at 2:38=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Sat, Apr 6, 2024 at 8:21=E2=80=AFPM <jmaloy@redhat.com> wrote:
> > >
> > > From: Jon Maloy <jmaloy@redhat.com>
> > >
> > > Testing of the previous commit ("tcp: add support for SO_PEEK_OFF")
> > > in this series along with the pasta protocol splicer revealed a bug i=
n
> > > the way tcp handles window advertising during extreme memory squeeze
> > > situations.
> > >
> > > The excerpt of the below logging session shows what is happeing:
> > >
> > > [5201<->54494]:     =3D=3D=3D=3D Activating log @ tcp_select_window()=
/268 =3D=3D=3D=3D
> > > [5201<->54494]:     (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)=
 --> TRUE
> > > [5201<->54494]:   tcp_select_window(<-) tp->rcv_wup: 2812454294, tp->=
rcv_wnd: 5812224, tp->rcv_nxt 2818016354, returning 0
> > > [5201<->54494]:   ADVERTISING WINDOW SIZE 0
> > > [5201<->54494]: __tcp_transmit_skb(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > >
> > > [5201<->54494]: tcp_recvmsg_locked(->)
> > > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_n=
ow): 500328))? --> time_to_ack: 0
> > > [5201<->54494]:     NOT calling tcp_send_ack()
> > > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window=
 now: 250164, qlen: 83
> > >
> > > [...]
> >
> > I would prefer a packetdrill test, it is not clear what is happening...
> >
> > In particular, have you used SO_RCVBUF ?
> >
> > >
> > > [5201<->54494]: tcp_recvmsg_locked(->)
> > > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_n=
ow): 500328))? --> time_to_ack: 0
> > > [5201<->54494]:     NOT calling tcp_send_ack()
> > > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window=
 now: 250164, qlen: 1
> > >
> > > [5201<->54494]: tcp_recvmsg_locked(->)
> > > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_n=
ow): 500328))? --> time_to_ack: 0
> > > [5201<->54494]:     NOT calling tcp_send_ack()
> > > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]: tcp_recvmsg_locked(<-) returning 57036 bytes, window =
now: 250164, qlen: 0
> > >
> > > [5201<->54494]: tcp_recvmsg_locked(->)
> > > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]:     NOT calling tcp_send_ack()
> > > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp-=
>rcv_wnd: 5812224, tp->rcv_nxt 2818016354
> > > [5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window no=
w: 250164, qlen: 0
> > >
> > > We can see that although we are adverising a window size of zero,
> > > tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
> > > between this side's and the peer's view of the current window size.
> > > - The peer thinks the window is zero, and stops sending.

Hi!

In my original logic, the client will send a zero-window
ack when it drops the skb because it is out of the
memory. And the peer SHOULD keep retrans the dropped
packet.

Does the peer do the transmission in this case? The receive
window of the peer SHOULD recover once the
retransmission is successful.

> > > - This side ends up in a cycle where it repeatedly caclulates a new
> > >   window size it finds too small to advertise.

Yeah,  the zero-window suppressed the sending of ack in
__tcp_cleanup_rbuf, which I wasn't aware of.

The ack will recover the receive window of the peer. Does
it make the peer retrans the dropped data immediately?
In my opinion, the peer still needs to retrans the dropped
packet until the retransmission timer timeout. Isn't it?

If it is, maybe we can do the retransmission immediately
if we are in zero-window from a window-shrink, which can
make the recovery faster.

[......]
> > Any particular reason to not cc Menglong Dong ?
> > (I just did)
>
> He is not working at Tencent any more. Let me CC here one more time.

Thanks for CC the new email of mine, it's very kind of you,
xing :/

