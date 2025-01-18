Return-Path: <netdev+bounces-159574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07CA15E36
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CF016092E
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3B3187561;
	Sat, 18 Jan 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H98Qyh9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F713B791
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219721; cv=none; b=Pb7VNkKK7loZWtMrvOevtyjYjDy5jO5fIF1e5m0uVVbUphax4U34TpgfdZtMedzXOzsB84UtgJfI/5C7f922GO0okHjSShkVE8s0Cplo0HRvpPHfoKcIycKs0zEENHdM4nzKnaVTVUohxDghIzCA1AO6p57ARVrZqqC7pt3ywLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219721; c=relaxed/simple;
	bh=M/bcnLFzNB/pDISdLF4DNkKiwzLnSWFng0kMg7lmA0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9dg+MwYCNFN4FuaLGMzzes+lwfwaTLO+AGsCfiIgarX35qz1ZEdnK0ugGn1+SAdhi8foAwAEmp4qYMw61trEfsU2ynKTjFhDmBlyfGTB8EOI0bNZu763iuXF8YVb53s4F+45eVQARUtIOLELslfbvQaKVEDbdHgOJuZ2Vk0u2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H98Qyh9t; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so14417875ab.1
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737219718; x=1737824518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mipqSWqCQw7mZMk4ZQpoBkHYub16XF6bdcgmVQvyxtA=;
        b=H98Qyh9tKcY0mLMtqrnjNSr6d1s5ih1p42xxALRCBKv4RH9LXFHuByXhe3yNIQb5eL
         ff3a0QpT692BIwTt2Hi66Ixb3Ma+5vFnvYaxX9fo78dFNBELqbPxqdK4FxDV9PtdLMci
         N0aDjrsUcuLym0d5WcWWi1DFn2x9037Cyv9Xfy/P2M+y8MdVabj7TgC8BiNDSZgIMsI/
         Xyxhsno895kLBvG1hCoe9AEsovkZHU7pgs2dh5DGFGVCWLdyTj44qtqo4s9tSQHGgobl
         mTlekgQ20rHpFHLkbjgMVHr4nPAAlQMRWCldyadNqPXNEW548OwqJ4UVrcYKEnK83pXq
         Qm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737219718; x=1737824518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mipqSWqCQw7mZMk4ZQpoBkHYub16XF6bdcgmVQvyxtA=;
        b=GlnbwJ0eEN2VUKohgdHssfspckX5Hr4xB2moI5Tv/yHL6nBdJzqYjHnM+1Oz7Fyfmf
         gGhGYllIx5l+s8ufBiTjEmdVmDEufuSCRhdkZ8DppDZk4qreixgGdu1hnrRQh9TDIsON
         zU06lAJ/D2ELj/FWnf0/3zWOi7ZNF/3td0sTV133v5vh0tZ9WLZ5QflU55nHyZE+dkYD
         Do4HFjS6NeuPQHldt936ec9uBjzz/oPe0BaLaA1SVEv2LTn9OxJomTzFvUWtwl3fGofu
         kjcHn9K7mZz4ugz8olS7yjgf1AZIViKHXci4FSL2uSBVkEKTm9jcqkUlDzXXoEPqC+Bp
         Asng==
X-Gm-Message-State: AOJu0YwqW/1fbgE80KvOT0GSlkfxxwvdj5SQxxXXyeUzUcp6cLLJxzJR
	g7BQp/s6vUBn0KIblMzu93j7ZHtpxxfIXNvRR45F8S4f7fOcAmR6/ORRFyBN0yyGvjkr/p5dUV7
	jJIe0gWkIWk3ta2i6OoGYqxB71QiLAxiQ
X-Gm-Gg: ASbGnctsGYE5N7cIuXUuwTtRQlRe6nRtUX3MZKw/gsQasBXkvoDZ9DSFQe2WMHTugX6
	Y+O2CbmFurIcE3iTVtuizRZzcBOhSKLcL6M7rtrKvh+mn2EZv4r4=
X-Google-Smtp-Source: AGHT+IF10JQwcOIvtPv3CY+5fwkcF932UvYFvzR6ETJE6IlLVPtI8GFJUiuRsMqWJj00qZsMlmmWIvRqzVEuw+yhw1c=
X-Received: by 2002:a05:6e02:8e:b0:3ce:7b33:8c3b with SMTP id
 e9e14a558f8ab-3cf747e2027mr53153855ab.5.1737219718316; Sat, 18 Jan 2025
 09:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com>
In-Reply-To: <20250117214035.2414668-1-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Jan 2025 01:01:22 +0800
X-Gm-Features: AbW1kvaM0FI6R_4QP_9t3-02uU6hJnG4ABj-eRb_TNp2n5h6Q2StvfHd4MEFDvk
Message-ID: <CAL+tcoDW1-c8v=RMBs=gvc9nvO0nm2fmpE+cV_sRFE-QwLV1vA@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, imagedong@tencent.com, eric.dumazet@gmail.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 5:41=E2=80=AFAM <jmaloy@redhat.com> wrote:
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

Thanks for such a detailed explanation :) However, undeniably, I've
read several times until I totally follow the issue you reported. I
wonder if you can compact and simplify the commit message a little
bit, say, remove the last two calltraces that can be replaced by a
single sentence like you've already stated (which is "the queue is
empty").

Let me rephrase the scenario to see if I'm understanding in the right way:
1. First time the receiver sends a skb with zero window because of
shortage of memory.
2. Sometimes the user calls the tcp_recvmsg() to remove the data from
kernel to user space, sending the ACK process should be triggered,
especially when the queue is empty.
3. Then the client reading the zero window signal stops sending data.

#1 fails to update the rcv_wup and rcv_wnd, so since then in the
manner of __tcp_cleanup_rbuf(), the rcv_window_now variable is always
the same in this case (please see the calculation in
tcp_receive_window()). rcv_window_now, which I presume is the same as
win_now in the above description, should vary when
__tcp_cleanup_rbuf() is called. Because of that, #2 could never send
an ACK.

My small question is why is the new_window always 262144 no matter
what amount of data the user receives? Is it because in
__tcp_select_window() there is no wscale option?

Thanks,
Jason

