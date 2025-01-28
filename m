Return-Path: <netdev+bounces-161244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9869BA202C1
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06903A737B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CAEEB5;
	Tue, 28 Jan 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyxDtyAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78321304BA
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738025559; cv=none; b=keTaZmcj9it0Yr66x3BFNMLkpXp6pJMEfx1kQbZOsiJKVEbAkffji34rPFaRvUzYBNFu9yGxSYRK8HuztVyX01efM4SMC4w8DfIdnBhWkbzF/R0lIjgmTCJNLX3tCyMKnj7W1WG9Pnl/b97aq9lIYRNxO9Cv0pT7HPmNQqNx1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738025559; c=relaxed/simple;
	bh=5V/hE7f3Lomh+vCHvCqxNyoqa7/2lwWxMOp37MaSsNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oeu0hzfFcmcdRKmMNCnUM858xcLq6XOlpAxl6aHiyrVwmnvEoakAJwIenBFAv70sUONf5C/tBnHfuqkxoTqXOn4TIK4ZaTbjPOJjVsfHqnNAEu62UFj24vOW7dX8SQbp04hR7DfrV4goH38Z7/FjIN7nJAjLiXeNxHxwgoyWySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyxDtyAm; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce868498d3so15459845ab.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 16:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738025557; x=1738630357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tEeDmUjY4CieUAYofp5Zv8e/F4uQypMegDgyNLo0SA=;
        b=JyxDtyAmGJrnME/Nkc5gXqGYGZFVQGx/f2rSrbS4ZfrYuSYvCnRosHzpLF5dBRIPQ4
         hYnUQDZ7HYazUwHTuEeYUWQIfggGJLPmLtxiniKRQ2zGNEMTz1vQAIwjF6FpxjHj09eG
         YUhvlDRgagYZm2lGY5CUgX9PvlNVpBab4rWb/doAWzZD2ZLX3GmgOLi48Ig6pJtUbTld
         y56n2YwyrJ9NksWcoa3uOI1eoTrAsXmyX3byL8Euq8gqU2ihViBsU9S9M8d2V2Yy9r8p
         9f9K7z9ozPD7Fs7JGlVODu0vgx7o6pFUmTl5bmhPzJMhyhPV6Q2qD64v18Ne9fSZig9A
         57xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738025557; x=1738630357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tEeDmUjY4CieUAYofp5Zv8e/F4uQypMegDgyNLo0SA=;
        b=LRu6JMQ+w1jXUtYW/n/HuDFYVUXmG81idrIgZSWZ3VT5hVB/thjJZKXJECtJ7Ah+hu
         G1ckSLwBvt0VF2uC6E0QTxMLYl30LqNZ1lawoX6zLmlgdIG+6r1QBDFlVoppyf4csb+O
         gLRuOqqUkZq5lzrYs2n3NQzN22Pjf+sjCtq1yMdfbEWpmxOyrTk2yIe+JGZmLBsc1WAc
         NSqHcOYBzRLkBsY72ZhxD/xjOEvktBevfp5qpk0oin6TT3SojxJGWkf1sW+edC+UshTb
         aRae3sheUgNSG8k78z8CMTIeoW1xjM8npWgNiC57sg2agGo8IgW5uvMI0Qa7EuN0iBnY
         O3kA==
X-Gm-Message-State: AOJu0Yx2YOJkpl/O/fNy9Y+mPVdFnZg8hB68TgNXHpoCBnBH11Bk6pk6
	/JOSEVCHYSGyoUqWnl6Y8vmTxjkSbtkYXP0/ambjIVt0I9TZ/GfvksHpv4mFuFt1VPT5Z2ceLuB
	rCNA7VnGkiSjv0JCLTI9gVvo7x+g=
X-Gm-Gg: ASbGncvpC2VrRVR6IdrJwJBBc2PeubR4arQv9lueG5azOrLJjvSdzpBBXMy90ZmX9S2
	K7tnuks9BqwmxkFAdAOPirjRXJmxqT/pLcE97PoXiy2NP9zR9v27f/RidnXGM
X-Google-Smtp-Source: AGHT+IGpJF52xzqROd7a+Z92UeGluIpLpNSHadhR7IvFddR48a66AR6n5IdpSajnwuWt+VVmH9euNAd1uh/RAHuXJoE=
X-Received: by 2002:a05:6e02:3f90:b0:3cf:c85c:4f60 with SMTP id
 e9e14a558f8ab-3cfc85c503fmr121696475ab.11.1738025556763; Mon, 27 Jan 2025
 16:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127231304.1465565-1-jmaloy@redhat.com>
In-Reply-To: <20250127231304.1465565-1-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jan 2025 08:52:00 +0800
X-Gm-Features: AWEUYZkCN2V3SODRx6bgIpH56rlewnK2p1DuLiILfZgMJg4_Lu8CCfFAxlXr2dA
Message-ID: <CAL+tcoAGXWP728aDwoGArVXX3zsPwLbUu+WjoopQj8R6W_CqbA@mail.gmail.com>
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, memnglong8.dong@gmail.com, ncardwell@google.com, 
	eric.dumazet@gmail.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:13=E2=80=AFAM <jmaloy@redhat.com> wrote:
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
>                        [OFO queue: gap: 65480, len: 0]
> [5201<->39222]:     tcp_data_queue(<-)
> [5201<->39222]:     __tcp_transmit_skb(->)
>                         [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp-=
>rcv_nxt 265600160]
> [5201<->39222]:       tcp_select_window(->)
> [5201<->39222]:         (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)=
 ? --> TRUE
>                         [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp-=
>rcv_nxt 265600160]
>                         returning 0
> [5201<->39222]:       tcp_select_window(<-)
> [5201<->39222]:       ADVERTISING WIN 0, ACK_SEQ: 265600160
> [5201<->39222]:     [__tcp_transmit_skb(<-)
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
>                     [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv=
_nxt 265600160]
> [5201<->39222]:   __tcp_cleanup_rbuf(<-)
>                   [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, =
win_now 131184]
>                   [copied_seq 260040464->260040464 (0), unread 5559696, q=
len 85, ofoq 0]
>                   returning 6104 bytes
> [5201<->39222]: tcp_recvmsg_locked(<-)
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
>                     [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv=
_nxt 265600160]
> [5201<->39222]:   __tcp_cleanup_rbuf(<-)
>                   [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, =
win_now 131184]
>                   [copied_seq 260099840->260171536 (71696), unread 542862=
4, qlen 83, ofoq 0]
>                   returning 131072 bytes
> [5201<->39222]: tcp_recvmsg_locked(<-)
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
>                     [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv=
_nxt 265600160]
> [5201<->39222]:   __tcp_cleanup_rbuf(<-)
>                   [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, =
win_now 131184]
>                   [copied_seq 265600160->265600160 (0), unread 0, qlen 0,=
 ofoq 0]
>                   returning 54672 bytes
> [5201<->39222]: tcp_recvmsg_locked(<-)
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
> We fix this by updating the socket state correctly when a packet has
> been dropped because of memory exhaustion and we have to advertize
> a zero window.
>
> Further testing shows that the connection recovers neatly from the
> squeeze situation, and traffic can continue indefinitely.
>
> Fixes: e2142825c120 ("net: tcp: send zero-window ACK when no memory")
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

I reckon that adding more description about why this case can be
triggered (the reason behind this case is the other side using other
kernels doesn't periodically send a window probe) is really necessary.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

