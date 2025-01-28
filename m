Return-Path: <netdev+bounces-161346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CBA20C94
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BB03A1E63
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363F1AF0B4;
	Tue, 28 Jan 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckwcdrG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08967BE40
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076690; cv=none; b=tKZxjvN55rA9aEthxDuH4kPZlnfeF8MsI+f10wJWe9OARLObpWuaAMk5b7hbWBJZ3KWHKFAi3fFbyrbHnlTeC8lnimprIU2KwNbGylBqtHr/Eet1ZGb/mx0s5Jr68xIL0Yzd+rGgXTLRbZ981RSxEhVLR2MWIDWzakWFx58fLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076690; c=relaxed/simple;
	bh=fAmEpo226QtHevfIyba67iDsWRi5SJvysppcugXKAyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6sQe77mlou47fHAHFVjitXDA8oXllltiydSEaM6zNhyX91PgE2O8+Pi/Z8SQj9GKoOtv+sk0Es8uJK27bJYWai3/njiRpMeVkMTKZnuf6UgABCuG+jB7ZwcIq5IF5UglqJFG7ptp1JkngANpsHcAURcQeuGUJJSEVl1C0YQawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckwcdrG/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so11261167a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 07:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738076687; x=1738681487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGL2HN8Fi3DZ+QAMnHPNFn5nofKWEuhiofUzFLXfui4=;
        b=ckwcdrG/baCPSkMr7V5rhi+laaCf+jMg5qKbM6JdL0FDwIy8qOSssh4vU5swo53DUM
         sJRW/Hs/AxEUNV/go3uuoHI/b1dST7gpp+6ahq8N0hzerW12t+wfmaMTWm2Q7GXLgQji
         XvF82mRX0GIRSaircde9GOLcaLUCgLhlUiiuSauYXWeMzhZR5efmof055weFEvs0kQQT
         CrUOK48TjIcMonuFvyOMQv12Xk1ZhEly585tfY53fvR1XEFPnH9MatUabwcA/as/7+BX
         6vo+cwSv/dUoGxg6H+2SBUwlrDt9JzS1e91Rg0frCSaXK4ixYPskW04EYY2nble41i2o
         9hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076687; x=1738681487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGL2HN8Fi3DZ+QAMnHPNFn5nofKWEuhiofUzFLXfui4=;
        b=IU8eJZkceaSIwVqcxRZ2EZ20ZhEUaI+6oVzd3nVFaWZEaDiLCcp2RzgKOOXm08OJfU
         uZDmp9VRWlGaCeWLdLVVPF+ZRM3Bit50HE9xop44hyPsqAGKc0wfEPLkmd7m55wRRwHy
         JihEXeQSqxRNVw8A3aZWVNiLs0HHq3Lq0iswVlMGM6nPiGgrw1KmVTeC8qOOHOXvurFC
         fm1jnuNK/22R3J9xPw9cuiN0rhzEj8cH4C/nlcwT06LmX/HjG5OxhVDQqGoJZvQz2ZJT
         k7R0QhINKOof/B1H0iLAWFdxWndFvVcGRsrmVQEyUtGHgDiCL7F6ZUny+IA9EDRYtWq6
         Hb2w==
X-Gm-Message-State: AOJu0YwqItbi/hnj6iMGUWvsU5SeWumNBCauiamt25xgXM1HYlL5viKt
	Aa6m5tfcLr9jzmTpg/1G6TWP81+IO+BEPK/UoqIOwZxlbCIe/3ZZoCVHooT9GZY7LOMA7hploqf
	Fl9cPlqIXtY59WXBy/gvG2OgMP0EPpxEmjIOuKlPyYZ2nk/EqVw==
X-Gm-Gg: ASbGncuct8SobWZ8fHDfPTp5rB7T77Tt9sIXPad5JL5KKs8Ch3zW/LNiz1Dh2ojo8Vf
	JV3bonS6esBeoPsHzm8Pu46/hu6ugBo3u9k6PlWKPfqEqzHQCpPLMUsWt6aWc1t/QR3ewdtVG
X-Google-Smtp-Source: AGHT+IG4TfeiDzyLV55UIi3oKvEjswQDFrkuEId3QHk3G2v8/Fk7yBARO4qNH5VDIlVndtab7nqCFhMiLnrTNvVioSw=
X-Received: by 2002:a05:6402:1d53:b0:5dc:10fe:4d6b with SMTP id
 4fb4d7f45d1cf-5dc10fe5068mr14887397a12.8.1738076686732; Tue, 28 Jan 2025
 07:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127231304.1465565-1-jmaloy@redhat.com>
In-Reply-To: <20250127231304.1465565-1-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 16:04:35 +0100
X-Gm-Features: AWEUYZkVMA_GntVpsZOW3H6t5RGIw4P6CdrSeoblQDHq3rqfDn6c2ELbk1Himzo
Message-ID: <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com, 
	ncardwell@google.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 12:13=E2=80=AFAM <jmaloy@redhat.com> wrote:
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

This so-called 'deadlock' only occurs if a remote TCP stack is unable
to send win0 probes.

In this case, sending some ACK will not help reliably if these ACK get lost=
.

I find the description tries very hard to hide a bug in another stack,
for some reason.

When under memory stress, not sending an opening ACK as fast as possible,
giving time for the host to recover from this memory stress was also a
sensible thing to do.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the fix.

