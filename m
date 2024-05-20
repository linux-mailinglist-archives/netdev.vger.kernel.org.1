Return-Path: <netdev+bounces-97218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9418CA0E2
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99651F2190C
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AB313776F;
	Mon, 20 May 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lciVPnnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79B79EF
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223905; cv=none; b=goKguXkbWVgOFTid1dLRxIxUAv32M+6uiUYWQEpVjQRhavny2i1wxLi5rraz8GPaSJ89CTTyJBJm7x9+U72sAmLVCfClhl+r7BlBur7OqgnDY2V4rN0s5jC0rD99PLOHFr/RgqysKANS5xOkJz5eY9tHY6bFZP/w7/JIzt2kmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223905; c=relaxed/simple;
	bh=/Ft9e+MLHJ+xfnQuREPQGmbNpYReW85nXo4jh7yklFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0ggQsc/j6H7GwcvipYikj6I0/4NwZc3QbPZgrIV30TPRAwjypwlxxNgqF3pvQbsg1zVGnGbR6plrdyFQUkAhYkBzyBT/VwyMmv0MPirrWLv9Tg6UJuu9G7yGrQk6Ohv61SeW7kp6Vs5u10167kqv0TLz/0QtgXB1liT+ZX5egE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lciVPnnd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso19504a12.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716223902; x=1716828702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oji7airr8+Gb4Qiav0NZIPCol2BZwLLesZL7/GSBoW4=;
        b=lciVPnndp7F5VrjvQRTO9uBhgikPD6hdpjHJY05mYaY2C9L1AFdPO+xSoyqbMmlHLX
         +ZuppQK35lgwrU2hLlx0CDuz/LE154QZF+BclikRDxInSVgSPBB15SGttp5fiwRUqUhw
         ZFs27Wt0vPpBYyW2VFSPOim73Dm2Hl9vhycIN6lhSAZD0y1dFU+3thHEfM+am+fXYGgG
         9VIvW0XrxBb9GILISY+w0/x+M5QiOYvcpLOqyUIGqpIl+VJV+F7blm/++cQilJYHupzu
         kEEVqJnROeja9fvIKzx2Tz8iv1wigToc2R3ZMojaoyqB0ncF/Yi5zBjSvil7rNVsjGQw
         UQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716223902; x=1716828702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oji7airr8+Gb4Qiav0NZIPCol2BZwLLesZL7/GSBoW4=;
        b=FFiYPfap/9cQZ7Y1DxZF6V/S9m6WVJCxmd4XHJWCjZ4iPDDiNzytDdSS87RCvjk/vS
         qyO1+CEasokam/YF/AQ3+edfDBLHcns2wmPZYpvTWOJiwHQ/U1Xq58KnqmtVODUQjFaF
         HSTZjd1TWI0oMxh+LqClYIFGEtlP1t2gfFrcTYf7/tZm1dA/dK89rUvwNlL6hTqmVXIs
         ZrOhoUFDUC4i9trvjWWNx3Jx8XdQXqQgYvf9WDJl8E5ptt4T/VJMlUdIfePux52uAdlJ
         xkiAuxdNQAVzbXiXdpqLVNXkpZyDdjOE5dq4pFCROIxdsrn+Xz19kB89r/levwucTeik
         v+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXLyYVQK9elzOYJGhsXjT0r3SjhWuJ3j2bPjTqJObEhYo+XzgtaeMr+P4VUKlLUyA9oUyJabDorNDBF7qnZPag0CwbsRj4R
X-Gm-Message-State: AOJu0YwvU+A4LaTgDafXYD+nGwY6rkJlxB2OymDouIXOcPTPoB+S9DEg
	21SiaV18x5wwOfJlSMynGaKn4W5+lnPT8X4v2tJSr1iR8+cAznbcs2Ro6xKnAAHOoCvP1WgIMp8
	N/pHNLpbGHiV2OHGzDgzy87JJarELvnG9pl8PgPXN4l4AI0qjzw==
X-Google-Smtp-Source: AGHT+IFajXURi2JOgipAHYSN47xPQS4MgycHgPkdptBe3zSWB8QM+PFlX6I1D2OdSphbh0bDqdUqWgtzhcYYR/V9oBo=
X-Received: by 2002:a05:6402:2158:b0:573:438c:778d with SMTP id
 4fb4d7f45d1cf-5752c3f15c3mr275976a12.1.1716223901799; Mon, 20 May 2024
 09:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518025008.70689-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240518025008.70689-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 18:51:30 +0200
Message-ID: <CANn89iJqmp36tYxFgrTYqZ69EFc9c=eK69dhfPhriAwpk-fW-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 net-next] tcp: remove 64 KByte limit for initial
 tp->rcv_wnd value
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 4:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin
> to around 64KB") limited the initial value of tp->rcv_wnd to 65535, most
> CDN team would not benefit from this change because they cannot have a
> large window to receive a big packet, which will be slowed down especiall=
y
> in long RTT.
>
> According to RFC 7323, it says:
>   "The maximum receive window, and therefore the scale factor, is
>    determined by the maximum receive buffer space."

This seems not relevant ?  wscale factor is not changed in this patch ?
tp->rcv_wnd is also not the maximum receive window.

>
> So we can get rid of this 64k limitation and let the window be tunable if
> the user wants to do it within the control of buffer space. Then many
> companies, I believe, can have the same behaviour as old days.

Not sure this has ever worked, see below.

Also, the "many companies ..." mention has nothing to do in a changelog.


> Besides,
> there are many papers conducting various interesting experiments which
> have something to do with this window and show good outputs in some cases=
,
> say, paper [1] in Yahoo! CDN.

I think this changelog is trying hard to sell something, but in
reality TCP 3WHS nature
makes your claims wrong.

Instead, you should clearly document that this problem can _not_ be
solved for both
active _and_ passive connections.

In the first RTT, a client (active connection) can not send more than
64KB, if TCP specs
are properly applied.

>
> To avoid future confusion, current change doesn't affect the initial
> receive window on the wire in a SYN or SYN+ACK packet which are set withi=
n
> 65535 bytes according to RFC 7323 also due to the limit in
> __tcp_transmit_skb():
>
>     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
>
> In one word, __tcp_transmit_skb() already ensures that constraint is
> respected, no matter how large tp->rcv_wnd is.
>
> Let me provide one example if with or without the patch:
> Before:
> client   --- SYN: rwindow=3D65535 ---> server
> client   <--- SYN+ACK: rwindow=3D65535 ----  server
> client   --- ACK: rwindow=3D65536 ---> server
> Note: for the last ACK, the calculation is 512 << 7.
>
> After:
> client   --- SYN: rwindow=3D65535 ---> server
> client   <--- SYN+ACK: rwindow=3D65535 ----  server
> client   --- ACK: rwindow=3D175232 ---> server
> Note: I use the following command to make it work:
> ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> For the last ACK, the calculation is 1369 << 7.
>
> We can pay attention to the last ACK in 3-way shakehand and notice that
> with the patch applied the window can reach more than 64 KByte.

You carefully avoided mentioning the asymmetry.
I do not think this is needed in the changelog, because this is adding
confusion.

>
> [1]: https://conferences.sigcomm.org/imc/2011/docs/p569.pdf
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20240517085031.18896-1-kerneljasonxing@=
gmail.com/
> 1. revise the title and body messages (Neal)
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 95caf8aaa8be..95618d0e78e4 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock *sk,=
 int __space, __u32 mss,
>         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_win=
dows))
>                 (*rcv_wnd) =3D min(space, MAX_TCP_WINDOW);
>         else
> -               (*rcv_wnd) =3D min_t(u32, space, U16_MAX);
> +               (*rcv_wnd) =3D space;

This is probably breaking some  packetdrill tests, but your change
might [1] be good,
especially because it allows DRS behavior to be consistent for large
MTU (eg MTU 9000) and bigger tcp_rmem[1],
even without playing with initrwnd attribute.

"ss -temoi " would display after connection setup  rcv_space:89600
instead of a capped value.

[1] This is hard to say, DRS is full of surprises.

