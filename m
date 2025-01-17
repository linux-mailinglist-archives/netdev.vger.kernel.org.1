Return-Path: <netdev+bounces-159475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8885A15967
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD613A8D5D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1B1B394E;
	Fri, 17 Jan 2025 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/Z/n6SN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE319E7D1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151783; cv=none; b=TqfFjHInUiJZ+5FfRHWeL3UuPhOQNbXG3aMcGmO8Dc7NVb8xU1JBq0zpKMvXsz9wiU8tV3pmCuIZd92mj/6HtWMcC2/AKTvP0YXp1Vick99gInQJhJzpJ9WOThmwKRASKWBhX+t3TMpzPx5Wf7qFdg8CTsQAEcfxafKeXIGVD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151783; c=relaxed/simple;
	bh=TgdxiP8Cy/+MZi4wY1jfwm6pjFQIZpDY3B/4fc4XnVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyLQjZVxzPDb8LClIReDEbqWBDX99oqqAxhZ80nt7KJdTcs9hc3oZjKybQBFldDsbOLnvsixOAL5dzOXkaSayrkLDqZ5eVWkqPVoufrcK/Ax+CmwgwcRlXiFlXKNcyhSPh8dxaR+WKRYj0I8WxkZtad6Hjj490UVFJPF5T304sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/Z/n6SN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso4506159a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737151778; x=1737756578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxWJt7vMg8HEzcChWeewww178yhKsckOUrymoyMFD/k=;
        b=d/Z/n6SNCITviLFlYFD1X/dTTRbHstPX9l0v/mz4r8L/+0ZFO9Y68EQPJpgw8kyOco
         tsLGr+P04hHA718ksLT8vhDK+x0jiHf76rxwJCch7SVgRV8E8OzEv0YiUlJs8Ayw2GFS
         Thep3nyeeqUtRGVvnoxTmUXVjvvj1Z/CVDbY5xnBT+C4y8Y7ry+EUMLChozF9FHrWz2l
         qW+J6MfukzhjJl9CO3ZdE3RQzdD2Q6mzpSlwBpo6TCxOMSkULfdAjz+JGyBTd8CGX1Id
         J+rnnf/U1qWgaOba90a+HGnir5i2QLZYeyy4/cw2v7VnY/ffwU+cqNCVuroIa2c4EiTU
         uENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151778; x=1737756578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxWJt7vMg8HEzcChWeewww178yhKsckOUrymoyMFD/k=;
        b=Sse+lx7B+NLL5jpyyM97HbsdOjRVp0PWi15HVfdGee+qDT0TnQKxXp1RznwI8fZhVV
         n7efh7VmyAX8Pg9/hTsI1mnT7tS1htNGxmrCtYlym6E/1+np+0fF8Bs8mDFMsg2jm0ie
         yCfDifHsLua2bkDjk7xrs2ofAuT5kzP/A1YSl4DjHLY5vwwNIhQmWDLdyR0xJF0V9qoy
         8gtyfowena6sV8TvBbglScgfHFafSJtIjTebemz0xFvanRNzJj2FbPHrtFWCnJMXJ/XT
         X9Caco7PJbQB3PxPUAFKsSGqlgJfazKIuw3DQPbzSJsHAE3eCxBFYo8c6I1TxDzcw7sS
         N/NQ==
X-Gm-Message-State: AOJu0Yys+rxC8nanjOEu0dRIijlmZoMy0PltinRGdOqwr0DHEpmBvSTG
	mKzfrGbYtw+w45n3lL/M1o6eC5ysuJCfD2eVvTWAnz2pYp5cPreKlzOEiMYjG2AGmrrcxuGeDD0
	MiXtOmZ17hFAJty5QqdJWCSTl8YAQRxM4JL7R
X-Gm-Gg: ASbGncvy3g03iPiDwoSrj7v54xRkoQ7m/p8kpgUyt3gqh/Qvbq5iobRoBMf6rIy9a3d
	wWpETLgaZHi60X30hteBuI8mYsK2IXSI3s4NPLuk=
X-Google-Smtp-Source: AGHT+IHBpLn7CckltR9Iv3FEUwqti86dy6iZKoFZ11zkG4eqmbDpfEUKhkGffGpmmJ25ruXFZ3HQY0wLc7SXoZuaxqs=
X-Received: by 2002:a05:6402:3487:b0:5d4:1ac2:277f with SMTP id
 4fb4d7f45d1cf-5db7d2f5efdmr3530043a12.9.1737151778437; Fri, 17 Jan 2025
 14:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com>
In-Reply-To: <20250117214035.2414668-1-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 23:09:27 +0100
X-Gm-Features: AbW1kvbbFQPAzAZTxBmIhZC7XdXJqVnCoapPkbiNBZUDhk7bt9XvflitbtApGpU
Message-ID: <CANn89i+Ks52JVTBsMFQBM4CqUR4cegXhbSCH77aMCqFpd-S_1A@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, imagedong@tencent.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:40=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> Testing with iperf3 using the "pasta" protocol splicer has revealed
> a bug in the way tcp handles window advertising in extreme memory
> squeeze situations.
>
> Under memory pressure, a socket endpoint may temporarily advertise
> a zero-sized window, but this is not stored as part of the socket data.
> The reasoning behind this is that it is considered a temporary setting
> which shouldn't influence any further calculations.
>
> However, if we happen to stall at an unfortunate value of the current
> window size, the algorithm selecting a new value will consistently fail
> to advertise a non-zero window once we have freed up enough memory.
> This means that this side's notion of the current window size is
> different from the one last advertised to the peer, causing the latter
> to not send any data to resolve the sitution.
>
> The problem occurs on the iperf3 server side, and the socket in question
> is a completely regular socket with the default settings for the
> fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.
>
> The following excerpt of a logging session, with own comments added,
> shows more in detail what is happening:
>
> //              tcp_v4_rcv(->)
> //                tcp_rcv_established(->)
> [5201<->39222]:     =3D=3D=3D=3D Activating log @ net/ipv4/tcp_input.c/tc=
p_data_queue()/5257 =3D=3D=3D=3D
> [5201<->39222]:     tcp_data_queue(->)
> [5201<->39222]:        DROPPING skb [265600160..265665640], reason: SKB_D=
ROP_REASON_PROTO_MEM
>                        [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469=
200, win_now 131184]
>                        [copied_seq 259909392->260034360 (124968), unread =
5565800, qlen 85, ofoq 0]
> [5201<->39222]:     tcp_data_queue(<-) OFO queue: gap: 65480, len: 0
> [5201<->39222]:     __tcp_transmit_skb(->)
> [5201<->39222]:       tcp_select_window(->) tp->rcv_wup: 265469200, tp->r=
cv_wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]:         (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)=
 --> TRUE
> [5201<->39222]:       tcp_select_window(<-) tp->rcv_wup: 265469200, tp->r=
cv_wnd: 262144, tp->rcv_nxt 265600160, returning 0
> [5201<->39222]:       ADVERTISING WIN 0, ACK_SEQ: 265600160
> [5201<->39222]:     __tcp_transmit_skb(<-) tp->rcv_wup: 265469200, tp->rc=
v_wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]:   tcp_rcv_established(<-)
> [5201<->39222]: tcp_v4_rcv(<-)
>
> // Receive queue is at 85 buffers and we are out of memory.
> // We drop the incoming buffer, although it is in sequence, and decide
> // to send an advertisement with a window of zero.
> // We don't update tp->rcv_wnd and tp->rcv_wup accordingly, which means
> // we unconditionally shrink the window.
>
> [5201<->39222]: tcp_recvmsg_locked(->)
> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]:     [new_win =3D 0, win_now =3D 131184, 2 * win_now =3D 2=
62368]
> [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0]
> [5201<->39222]:     NOT calling tcp_send_ack()
> [5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]: tcp_recvmsg_locked(<-) returning 6104 bytes.
>                 [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, wi=
n_now 131184]
>                 [copied_seq 260040464->260040464 (0), unread 5559696, qle=
n 85, ofoq 0]
>
> // After each read, the algorithm for calculating the new receive
> // window in __tcp_cleanup_rbuf() finds it is too small to advertise
> // or to update tp->rcv_wnd.
> // Meanwhile, the peer thinks the window is zero, and will not send
> // any more data to trigger an update from the interrupt mode side.
>
> [5201<->39222]: tcp_recvmsg_locked(->)
> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]:     [new_win =3D 262144, win_now =3D 131184, 2 * win_now =
=3D 262368]
> [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0]
> [5201<->39222]:     NOT calling tcp_send_ack()
> [5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]: tcp_recvmsg_locked(<-) returning 131072 bytes.
>                 [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, wi=
n_now 131184]
>                 [copied_seq 260099840->260171536 (71696), unread 5428624,=
 qlen 83, ofoq 0]
>
> // The above pattern repeats again and again, since nothing changes
> // between the reads.
>
> [...]
>
> [5201<->39222]: tcp_recvmsg_locked(->)
> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]:     [new_win =3D 262144, win_now =3D 131184, 2 * win_now =
=3D 262368]
> [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0]
> [5201<->39222]:     NOT calling tcp_send_ack()
> [5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]: tcp_recvmsg_locked(<-) returning 131072 bytes.
>                 [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, wi=
n_now 131184]
>                 [copied_seq 265469200->265545488 (76288), unread 54672, q=
len 1, ofoq 0]
>
> [5201<->39222]: tcp_recvmsg_locked(->)
> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]:     [new_win =3D 262144, win_now =3D 131184, 2 * win_now =
=3D 262368]
> [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0]
> [5201<->39222]:     NOT calling tcp_send_ack()
> [5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_=
wnd: 262144, tp->rcv_nxt 265600160
> [5201<->39222]: tcp_recvmsg_locked(<-) returning 54672 bytes.
>                 [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, wi=
n_now 131184]
>                 [copied_seq 265600160->265600160 (0), unread 0, qlen 0, o=
foq 0]
>
> // The receive queue is empty, but no new advertisement has been sent.
> // The peer still thinks the receive window is zero, and sends nothing.
> // We have ended up in a deadlock situation.
>
> Furthermore, we have observed that in these situations this side may
> send out an updated 'th->ack_seq=C2=B4 which is not stored in tp->rcv_wup
> as it should be. Backing ack_seq seems to be harmless, but is of
> course still wrong from a protocol viewpoint.
>
> We fix this by setting tp->rcv_wnd and tp->rcv_wup even when a packet
> has been dropped because of memory exhaustion and we have to advertize
> a zero window.
>
> Further testing shows that the connection recovers neatly from the
> squeeze situation, and traffic can continue indefinitely.
>
> Fixes: e2142825c120 ("net: tcp: send zero-window ACK when no memory")
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> ---
> v1: -Posted on Apr 6, 2024

Could you post the link, this was a long time ago and I forgot the context.

> v2: -Improved commit log to clarify how we end up in this situation.
>     -After feedback from Eric Dumazet, removed references to use of
>      SO_PEEK and SO_PEEK_OFF which may lead to a misunderstanding
>      about how this situation occurs. Those flags are used at the
>      peer side's incoming connection, and not on this one.
> ---
>  net/ipv4/tcp_output.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0e5b9a654254..ba295f798e5e 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -265,11 +265,13 @@ static u16 tcp_select_window(struct sock *sk)
>         u32 cur_win, new_win;
>
>         /* Make the window 0 if we failed to queue the data because we
> -        * are out of memory. The window is temporary, so we don't store
> -        * it on the socket.
> +        * are out of memory.
>          */
> -       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
> +       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
> +               tp->rcv_wnd =3D 0;
> +               tp->rcv_wup =3D tp->rcv_nxt;

I wonder if we should not clear tp->pred_flags here ?

Also, any chance you could provide a packetdrill test ?

Your changelog contains traces that are hard to follow.

Thanks.

