Return-Path: <netdev+bounces-85452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154AE89ACA4
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB5AB21528
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C338DF2;
	Sat,  6 Apr 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrg5w6M+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7D1F16B
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712428674; cv=none; b=AqfDiVtsHq1nPoLcwNrowLlRiReGjmv5JEGg80HNIgLzo9iaxUtG+ztPJ8u5wfQIQrYtCSiFU9E5QnVXGstObdzEHSuVA3XkUNmsZ0Bd2pujFVGapBNSnw8d4MQ3XG4zoZYIzuO+i1H/bzD14aYGOwT0oXRkGNyEpOgt2f8s23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712428674; c=relaxed/simple;
	bh=pVyno5FUU06QcOnKBkCBLZuitqukqwVq2ShJhgAAxc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SV5SVwpEVcqMAdlXUCA4jDVyg8GX9wLe4v8/q7ZaP9meFUSt0h0BLQhc5hFHu0zx3YfAXqkqMBp0JENHDQ6K80nN2HP8TFlDWmjwKrR350pFKHn1sJ6Lc2CALsLVvgR24xD0HCHj0ZDso2fJpf9xW1fHXXIGzDaxEX27HEcpSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrg5w6M+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so7489a12.0
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712428670; x=1713033470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXiaeiDriebfXzGJiJC2yW3jLrxaZ2tj8awoa8ujxwA=;
        b=hrg5w6M+EFb2qJExhUtNKgOtFgJWxzXwA14Bd/Bd55K+/wEV8cbyoA3z5CuyynUDe4
         xIHd8UJ7gWcDJdDrgzon4eppnCQj3J7HOLY1u3TUyJMqc7mCSYiB0aOYauPxzZnLvBvM
         xaWMCozr89DFF7Aj/ipM5XTgYEfrCM/zzCSja6tPNV1GTHQ+auMGXS1nqkJmVo8HQmjf
         WinZ7T7Yj8WPzF96zzsxOuW/QiHChYylV8E8ARp4iNmiHUepM4zsliqIMMGDj159Xoa7
         iN8CsbtJSpNHi1LozeFE3Td1zLUeCt8jbbNUAE+HVGoAL+yrKcQqN2DR+5Y2vNkuRG87
         rWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712428670; x=1713033470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXiaeiDriebfXzGJiJC2yW3jLrxaZ2tj8awoa8ujxwA=;
        b=ro2AvQzppaDq+hpkIg3gkONqcu4wy5lrD2e9fzmECawjYIbkBadUleFrE4xc/wrrWQ
         lM8jO/29O3Ox4Eq1uZwOydn+J4ixaqfexSgQGc24sPCpv+dtZti0YJmLDNFrbAyJVy24
         FTIhl4kgebfaFS1ZtW6fzH5PB6bhbZ9mbTNCbsW284UEvkyuvxs/MiUe3iEYTrr91gnJ
         uk+UyiAnJFaiDtfTpoZNjrio1nQd7Z8D03/TY0JRu0qCRbOAj9PsxWpfLftgS3S2PWXh
         AwMj4/qwWiELvCyl1Nfy9FKza5dN7fLg7HcWrWXrtE3XZz+XhVWazucv/p4eEXgAmBue
         RWyQ==
X-Gm-Message-State: AOJu0YzhZO3QmpKGTZyKcZ+Qo3+3LnhZBywvp9To877W4Cj9YHjMd0Vd
	WbN6cm+D8f29Ts5cnI9uuXe3oOSoGh/AbeMPNzo4MTNi0MiaLeE07wUEQw+ByTD7p9sOM8lGpV7
	u9tyd3L+wXCNDFRFhVjS4CnvCLftjtJYuLBEy
X-Google-Smtp-Source: AGHT+IEty72s9OzFyTi5pHlJFZrQLvzxGjU1K9N6gYeWeNs+IZWQ5D6h6eMxU+sQ6LHwIgx1sJ6irMo6KsPxDKC/Klc=
X-Received: by 2002:a05:6402:c9b:b0:56e:3486:25a3 with SMTP id
 cm27-20020a0564020c9b00b0056e348625a3mr75240edb.1.1712428670233; Sat, 06 Apr
 2024 11:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406182107.261472-1-jmaloy@redhat.com> <20240406182107.261472-3-jmaloy@redhat.com>
In-Reply-To: <20240406182107.261472-3-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Apr 2024 20:37:35 +0200
Message-ID: <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
Subject: Re: [net-next 2/2] tcp: correct handling of extreme menory squeeze
To: jmaloy@redhat.com, Menglong Dong <imagedong@tencent.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 8:21=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> Testing of the previous commit ("tcp: add support for SO_PEEK_OFF")
> in this series along with the pasta protocol splicer revealed a bug in
> the way tcp handles window advertising during extreme memory squeeze
> situations.
>
> The excerpt of the below logging session shows what is happeing:
>
> [5201<->54494]:     =3D=3D=3D=3D Activating log @ tcp_select_window()/268=
 =3D=3D=3D=3D
> [5201<->54494]:     (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM) -->=
 TRUE
> [5201<->54494]:   tcp_select_window(<-) tp->rcv_wup: 2812454294, tp->rcv_=
wnd: 5812224, tp->rcv_nxt 2818016354, returning 0
> [5201<->54494]:   ADVERTISING WINDOW SIZE 0
> [5201<->54494]: __tcp_transmit_skb(<-) tp->rcv_wup: 2812454294, tp->rcv_w=
nd: 5812224, tp->rcv_nxt 2818016354
>
> [5201<->54494]: tcp_recvmsg_locked(->)
> [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now):=
 500328))? --> time_to_ack: 0
> [5201<->54494]:     NOT calling tcp_send_ack()
> [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window now=
: 250164, qlen: 83
>
> [...]

I would prefer a packetdrill test, it is not clear what is happening...

In particular, have you used SO_RCVBUF ?

>
> [5201<->54494]: tcp_recvmsg_locked(->)
> [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now):=
 500328))? --> time_to_ack: 0
> [5201<->54494]:     NOT calling tcp_send_ack()
> [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window now=
: 250164, qlen: 1
>
> [5201<->54494]: tcp_recvmsg_locked(->)
> [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now):=
 500328))? --> time_to_ack: 0
> [5201<->54494]:     NOT calling tcp_send_ack()
> [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]: tcp_recvmsg_locked(<-) returning 57036 bytes, window now:=
 250164, qlen: 0
>
> [5201<->54494]: tcp_recvmsg_locked(->)
> [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]:     NOT calling tcp_send_ack()
> [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> [5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window now: 2=
50164, qlen: 0
>
> We can see that although we are adverising a window size of zero,
> tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
> between this side's and the peer's view of the current window size.
> - The peer thinks the window is zero, and stops sending.
> - This side ends up in a cycle where it repeatedly caclulates a new
>   window size it finds too small to advertise.
>
> Hence no messages are received, and no acknowledges are sent, and
> the situation remains locked even after the last queued receive buffer
> has been consumed.
>
> We fix this by setting tp->rcv_wnd to 0 before we return from the
> function tcp_select_window() in this particular case.
> Further testing shows that the connection recovers neatly from the
> squeeze situation, and traffic can continue indefinitely.
>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> ---
>  net/ipv4/tcp_output.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 9282fafc0e61..57ead8f3c334 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -263,11 +263,15 @@ static u16 tcp_select_window(struct sock *sk)
>         u32 cur_win, new_win;
>
>         /* Make the window 0 if we failed to queue the data because we
> -        * are out of memory. The window is temporary, so we don't store
> -        * it on the socket.
> +        * are out of memory. The window needs to be stored in the socket
> +        * for the connection to recover.
>          */
> -       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
> -               return 0;
> +       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
> +               new_win =3D 0;
> +               tp->rcv_wnd =3D 0;
> +               tp->rcv_wup =3D tp->rcv_nxt;
> +               goto out;
> +       }
>
>         cur_win =3D tcp_receive_window(tp);
>         new_win =3D __tcp_select_window(sk);
> @@ -301,7 +305,7 @@ static u16 tcp_select_window(struct sock *sk)
>
>         /* RFC1323 scaling applied */
>         new_win >>=3D tp->rx_opt.rcv_wscale;
> -
> +out:
>         /* If we advertise zero window, disable fast path. */
>         if (new_win =3D=3D 0) {
>                 tp->pred_flags =3D 0;
> --
> 2.42.0
>

Any particular reason to not cc Menglong Dong ?
(I just did)

This code was added in

commit e2142825c120d4317abf7160a0fc34b3de532586
Author: Menglong Dong <imagedong@tencent.com>
Date:   Fri Aug 11 10:55:27 2023 +0800

    net: tcp: send zero-window ACK when no memory

    For now, skb will be dropped when no memory, which makes client keep
    retrans util timeout and it's not friendly to the users.

    In this patch, we reply an ACK with zero-window in this case to update
    the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
    connection and will probe the zero-window with the retransmits.

    Signed-off-by: Menglong Dong <imagedong@tencent.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

