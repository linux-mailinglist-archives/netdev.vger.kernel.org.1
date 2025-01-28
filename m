Return-Path: <netdev+bounces-161385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC3A20DC7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387B7188264B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCED1D63EB;
	Tue, 28 Jan 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGZ4gYVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE001D63C8
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079822; cv=none; b=tj8yty5E6hmq7uLGbaArs74rWtR68rfop943tWJNHFoqRlkdSECLRUajid4l5SqNQglDll3xpPKB8ZET7hbr6Hovs6TZzs2nXE1/Eq5+/YcuILWz81GkIcbtzFitizDP8dt2jmxOEMjvrFedO80JrvwGRUJrynHqfHqurSOsqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079822; c=relaxed/simple;
	bh=bQoiBUVxUKOhGX4ycdUyUcO/hOxt/GdS2o8rlCDiRMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAIDKD7GbrL1oMu4ltRXMBMVfwL2labNJZWGFkFAeMUOptycKc5GLkHOzJqE1os4sUVTMRcOtVdKYtQeW0IwGjNvj7BfkfNk9jjmiq0O1y81N5qGs6TqVcd2HFDZJqJYOkYPKG9g8S2furbsyKGO96hG/ndN4F8avuO/YRXenRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGZ4gYVg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4679b5c66d0so247111cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738079819; x=1738684619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC+LZicoEWTDrXa8gIlyMQe9ZNUpFhkwdWfwBf9KAKs=;
        b=nGZ4gYVgtWxSwALRVSrZ2IFCbfwSpl1D7EwYI9UuPRS0O5tGglHtA27ondw7+25aCG
         KuxXfuCF305qVp/Wdk1PXRoWlssZlTXdlAqu3yWMugOGwvxv8BD6gJ5aSIcSYqQna6ss
         XVM9mwr7axQH1DTMOkuAVexpK4IuHbG5k/xoVd9eQD7SkoYq2sil2BVmin0wrajNPjdE
         GkPBkVojmc4F1os4fO0Jz6mtd5gEv72ebQLu8T6Hpfz360N0EvjMrR0EQ1Ph4uLDRmKT
         mlIJfrfOodoyd9yGCFRN2n4lvLWD1XAJdR5tN7/3X+hSQLUjToFRp2Fsq+IqqEAcVi4C
         mMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738079819; x=1738684619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC+LZicoEWTDrXa8gIlyMQe9ZNUpFhkwdWfwBf9KAKs=;
        b=wSeiheUS0CsWMEEPCX1nP3fw+VWbqT7jjvhSIPgvX++gMcw1eGzLqnZSWmYozGEjJz
         Bkz9ASTM8eXjVrWloFyNGQVHro26Y7kNUzPSd8F+q2VafheRxczNcUIDRGbN3ivnsZBy
         cnRQBd8UA+G7CmZ+6pB7wRfdLe562+n5FnbsXkKKOaqJQwkuCxMWKirawniaV8a1G1ad
         GFTSHbEenyXNkIUHiinVB0yQx2qcwmgGc2ZrUuUIn0RVOdfVPYsfX/3iqaSzympbtz7U
         0eOC/+ZZf2JoHPHHeTGNs7X9P6+M6sqA05boBJd04Z4CYMg5Mcx2X1/pYNAhBFvHp60x
         Wo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/AgUuHNPsoWY113NDoh8AY/3muZSEbbu22dAylO8u3qo0L/1LW+i13zZrKHppmonEgAdgFN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx72BqGaCxPExMXXjtq36TcB2YiqgkkPZU8FPfRCdTiHFgdmqL
	w9pWKLodr0Tko95LrtlRzkFmnBnt1cWb1nvbpe1XMHkmgiQ4GnT1jXX9osZxzn2H5nrsy7eHPPO
	tXxQKVZweiPGi09rRMNJqkElb55CIn63O9WDa
X-Gm-Gg: ASbGncvYah2+3vEZfSDj3Fd1F1/msNKSigPEnB0cp7szktHKL6TFBieeDMOQ8Ocouhs
	EPxY4WJgZ8zsq1V11AvP9GIGTGs0zdLDE8iIh0xKrqhXHNKeQ+DCQykeT6xh4xRx3Hbw9QuiRPr
	2M4B5r0rWRupLh8b0F65xlOuQerxpgEg==
X-Google-Smtp-Source: AGHT+IFGsQQGg+KSO7AaQLkWSInBTpx3GfAcqnDaZful/E+cvDQIv65rsHwTny6oCmFrZuQ2dyl5joTdhyKfL9O3D1Q=
X-Received: by 2002:ac8:59c5:0:b0:466:a11c:cad2 with SMTP id
 d75a77b69052e-46fc631483amr3358481cf.7.1738079819459; Tue, 28 Jan 2025
 07:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127231304.1465565-1-jmaloy@redhat.com> <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
In-Reply-To: <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 28 Jan 2025 10:56:43 -0500
X-Gm-Features: AWEUYZl9RKC106JC04jAYPE4HVeowf_BD0ZYPUAWJTPS297Hu8OW2_LA3LyC3is
Message-ID: <CADVnQyn7afmGhuUOEzvFV099476pxrAUHE+FVnmiwwbo1tu1oA@mail.gmail.com>
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
To: Eric Dumazet <edumazet@google.com>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:04=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Jan 28, 2025 at 12:13=E2=80=AFAM <jmaloy@redhat.com> wrote:
> >
> > From: Jon Maloy <jmaloy@redhat.com>
> >
> > Testing with iperf3 using the "pasta" protocol splicer has revealed
> > a bug in the way tcp handles window advertising in extreme memory
> > squeeze situations.
> >
> > Under memory pressure, a socket endpoint may temporarily advertise
> > a zero-sized window, but this is not stored as part of the socket data.
> > The reasoning behind this is that it is considered a temporary setting
> > which shouldn't influence any further calculations.
> >
> > However, if we happen to stall at an unfortunate value of the current
> > window size, the algorithm selecting a new value will consistently fail
> > to advertise a non-zero window once we have freed up enough memory.
> > This means that this side's notion of the current window size is
> > different from the one last advertised to the peer, causing the latter
> > to not send any data to resolve the sitution.
> >
> > The problem occurs on the iperf3 server side, and the socket in questio=
n
> > is a completely regular socket with the default settings for the
> > fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.
> >
> > The following excerpt of a logging session, with own comments added,
> > shows more in detail what is happening:
> >
> > //              tcp_v4_rcv(->)
> > //                tcp_rcv_established(->)
> > [5201<->39222]:     =3D=3D=3D=3D Activating log @ net/ipv4/tcp_input.c/=
tcp_data_queue()/5257 =3D=3D=3D=3D
> > [5201<->39222]:     tcp_data_queue(->)
> > [5201<->39222]:        DROPPING skb [265600160..265665640], reason: SKB=
_DROP_REASON_PROTO_MEM
> >                        [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 2654=
69200, win_now 131184]
> >                        [copied_seq 259909392->260034360 (124968), unrea=
d 5565800, qlen 85, ofoq 0]
> >                        [OFO queue: gap: 65480, len: 0]
> > [5201<->39222]:     tcp_data_queue(<-)
> > [5201<->39222]:     __tcp_transmit_skb(->)
> >                         [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, t=
p->rcv_nxt 265600160]
> > [5201<->39222]:       tcp_select_window(->)
> > [5201<->39222]:         (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOME=
M) ? --> TRUE
> >                         [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, t=
p->rcv_nxt 265600160]
> >                         returning 0
> > [5201<->39222]:       tcp_select_window(<-)
> > [5201<->39222]:       ADVERTISING WIN 0, ACK_SEQ: 265600160
> > [5201<->39222]:     [__tcp_transmit_skb(<-)
> > [5201<->39222]:   tcp_rcv_established(<-)
> > [5201<->39222]: tcp_v4_rcv(<-)
> >
> > // Receive queue is at 85 buffers and we are out of memory.
> > // We drop the incoming buffer, although it is in sequence, and decide
> > // to send an advertisement with a window of zero.
> > // We don't update tp->rcv_wnd and tp->rcv_wup accordingly, which means
> > // we unconditionally shrink the window.
> >
> > [5201<->39222]: tcp_recvmsg_locked(->)
> > [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rc=
v_wnd: 262144, tp->rcv_nxt 265600160
> > [5201<->39222]:     [new_win =3D 0, win_now =3D 131184, 2 * win_now =3D=
 262368]
> > [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0=
]
> > [5201<->39222]:     NOT calling tcp_send_ack()
> >                     [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->r=
cv_nxt 265600160]
> > [5201<->39222]:   __tcp_cleanup_rbuf(<-)
> >                   [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200=
, win_now 131184]
> >                   [copied_seq 260040464->260040464 (0), unread 5559696,=
 qlen 85, ofoq 0]
> >                   returning 6104 bytes
> > [5201<->39222]: tcp_recvmsg_locked(<-)
> >
> > // After each read, the algorithm for calculating the new receive
> > // window in __tcp_cleanup_rbuf() finds it is too small to advertise
> > // or to update tp->rcv_wnd.
> > // Meanwhile, the peer thinks the window is zero, and will not send
> > // any more data to trigger an update from the interrupt mode side.
> >
> > [5201<->39222]: tcp_recvmsg_locked(->)
> > [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rc=
v_wnd: 262144, tp->rcv_nxt 265600160
> > [5201<->39222]:     [new_win =3D 262144, win_now =3D 131184, 2 * win_no=
w =3D 262368]
> > [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0=
]
> > [5201<->39222]:     NOT calling tcp_send_ack()
> >                     [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->r=
cv_nxt 265600160]
> > [5201<->39222]:   __tcp_cleanup_rbuf(<-)
> >                   [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200=
, win_now 131184]
> >                   [copied_seq 260099840->260171536 (71696), unread 5428=
624, qlen 83, ofoq 0]
> >                   returning 131072 bytes
> > [5201<->39222]: tcp_recvmsg_locked(<-)
> >
> > // The above pattern repeats again and again, since nothing changes
> > // between the reads.
> >
> > [...]
> >
> > [5201<->39222]: tcp_recvmsg_locked(->)
> > [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rc=
v_wnd: 262144, tp->rcv_nxt 265600160
> > [5201<->39222]:     [new_win =3D 262144, win_now =3D 131184, 2 * win_no=
w =3D 262368]
> > [5201<->39222]:     [new_win >=3D (2 * win_now) ? --> time_to_ack =3D 0=
]
> > [5201<->39222]:     NOT calling tcp_send_ack()
> >                     [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->r=
cv_nxt 265600160]
> > [5201<->39222]:   __tcp_cleanup_rbuf(<-)
> >                   [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200=
, win_now 131184]
> >                   [copied_seq 265600160->265600160 (0), unread 0, qlen =
0, ofoq 0]
> >                   returning 54672 bytes
> > [5201<->39222]: tcp_recvmsg_locked(<-)
> >
> > // The receive queue is empty, but no new advertisement has been sent.
> > // The peer still thinks the receive window is zero, and sends nothing.
> > // We have ended up in a deadlock situation.
>
> This so-called 'deadlock' only occurs if a remote TCP stack is unable
> to send win0 probes.
>
> In this case, sending some ACK will not help reliably if these ACK get lo=
st.
>
> I find the description tries very hard to hide a bug in another stack,
> for some reason.
>
> When under memory stress, not sending an opening ACK as fast as possible,
> giving time for the host to recover from this memory stress was also a
> sensible thing to do.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks for the fix.

Yes, thanks for the fix. LGTM as well.

Reviewed-by: Neal Cardwell <ncardwell@google.com>

BTW, IMHO it would be nice to have some sort of NET_INC_STATS() of an
SNMP stat for this case, since we have SNMP stat increases for other
0-window cases. That could help debugging performance problems from
memory pressure and zero windows. But that can be in a separate patch
for net-next once this fix is in net-next.

neal

