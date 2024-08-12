Return-Path: <netdev+bounces-117727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E1E94EF15
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF6C281257
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF617C230;
	Mon, 12 Aug 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G31xddeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35F153810;
	Mon, 12 Aug 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471274; cv=none; b=JNuISO0NJABrq3kAohxzzOMPkHrd23HiX9Ni867xOCq62N+E/RESFDHJUmPrWgAHYXyrhlqLRDeJ5ZUlMjOUj4QPGFFFxDJmwY8ivFiz+UFlgRkTKSp7QXUm4iAMMg7pzHCKUVFeRCnkaH71JNkQzietD4KIyOBzVPFjzxTx+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471274; c=relaxed/simple;
	bh=9BIsgZXodvtrwWeb7cKo+U/cApnCyeGkwGwDGZ9LXIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwUQ21xPuOma6+d6n31rX9WjfMYntnLMX3/Gh5oWy5CQbpzYaJRvYDmFHdIqFawNCqELF7Wrair9kNmttmi+6K4qLjO7nOC/DyFuxq+bz9QCnPrQYD1fJp8Ll2tElL5zkdt1K7vlU55Yve8x2j7ZKgs4o+Qq5KdfmQRrZuIrMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G31xddeM; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39641271f2aso13955125ab.3;
        Mon, 12 Aug 2024 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723471272; x=1724076072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFnjZsj2r+zwEpeVqommUpOZ0oV5AgwvWoyMDCMH3VU=;
        b=G31xddeMswLTWOI460atmQOlQ03UD6sRwx9oG6S+CXAuHQfPUz/xIL5nDV33IPDxQg
         SYTSrj/FwMXJSGvwcvBV9yTEmecmTZvszdZ5CnWx9g2qXt/P+YpM2k9UuH1VHsoDgMJF
         5wQM7wWcggqYm9rrLUXR8wfAwFCATdSjXbsEXySBLwaaJTNHy+qsoGo1ShKgBrhr+qhm
         Mev0Jz3xD9+JyF3v5MjBEDuAniYMaaHQoY5rvA0kpomUvVnuXkQah6eYofbvDOxlINd8
         fkDqu/IqvFRV5LnDIls590rMPPmQopma9DkYQg09gSWoOWMv+4pjpB9YUlrt/4QkPCFm
         3uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723471272; x=1724076072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFnjZsj2r+zwEpeVqommUpOZ0oV5AgwvWoyMDCMH3VU=;
        b=WI4T8v918UgCYC5ihgCxZuQVZ3nLRfcpyFe3Qd1FpjVR2InPb/Rf7/oBXeoo7y9onS
         2lH4NcZrYJVTpwxTyindcm2WFV+jPo+IHQv9XPBu2Z7RH7zu/QA+JttpL/rxXwiI1IpY
         fTSVJ+6uPFB3k134rOBAZdRAK+OSFqFvBKMkn2CFARcAeLayw9mx3G4NmJR/DFQnE0hf
         0Y8vgwZbVRpB0qhuc01qcQpJVcMHCkS78l90wy+oPrcUtephvx6MpYHz6YYo32xhfHDy
         humzOHhMzVi/u5ogAmfvDGrcQkJJy7kinvCVDXSjc3I882aodlcj5iX4sBquDsZNWeVf
         GdXg==
X-Forwarded-Encrypted: i=1; AJvYcCWiiiWllvKVmNffxg2gQfDB2/cCDyTngi9Sb/pH5V3NhAKDXDUlyWG+WXHClFQSZK5Z7K5uFKl8hsxKLexvVAO4824AdNVI/XdJuVB3TV0xFwXuzdYdN/OS1NEvIq00nxyswJVX
X-Gm-Message-State: AOJu0Yz3MrkutqtnfYH2GR/CsdPGfFWvjEESGLiIgadIpCm6oagZ+f6E
	5XoGn/6kiRstTfVnlQ0qKKcf3Oay4oBdogOWS1DMzWuEIBmJcqEVE/RreU17KFNY/pzfX3r5MSe
	kTiB0mA9K61pH+SGUbxWsfH+yBV0=
X-Google-Smtp-Source: AGHT+IFw/xnIktjg4fdXk7ElH9aJUyYLCKY2Ave3hB2lkpCuwEmQf/KbdJ7gwh0Nf1MIry+bK7Oqkna7yAfPtZLKGiU=
X-Received: by 2002:a05:6e02:190b:b0:382:a077:b9e7 with SMTP id
 e9e14a558f8ab-39c478d0fcdmr2971355ab.21.1723471271709; Mon, 12 Aug 2024
 07:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812105315.440718-1-kuro@kuroa.me>
In-Reply-To: <20240812105315.440718-1-kuro@kuroa.me>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 12 Aug 2024 22:00:34 +0800
Message-ID: <CAL+tcoApiWPx8JW9DeQ6VbAH7Dnqtw7PmVVvup9HMyBHHDhvcQ@mail.gmail.com>
Subject: Re: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:53=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote:
>
> We have some problem closing zero-window fin-wait-1 tcp sockets in our
> environment. This patch come from the investigation.
>
> Previously tcp_abort only sends out reset and calls tcp_done when the
> socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
> purging the write queue, but not close the socket and left it to the
> timer.
>
> While purging the write queue, tp->packets_out and sk->sk_write_queue
> is cleared along the way. However tcp_retransmit_timer have early
> return based on !tp->packets_out and tcp_probe_timer have early
> return based on !sk->sk_write_queue.
>
> This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> and socket not being killed by the timers, converting a zero-windowed
> orphan into a forever orphan.
>
> This patch removes the SOCK_DEAD check in tcp_abort, making it send
> reset to peer and close the socket accordingly. Preventing the
> timer-less orphan from happening.
>
> According to Lorenzo's email in the v1 thread, the check was there to
> prevent force-closing the same socket twice. That situation is handled
> by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
> already closed.
>
> The -ENOENT code comes from the associate patch Lorenzo made for
> iproute2-ss; link attached below.
>
> Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3=
-git-send-email-lorenzo@google.com/
> Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> Signed-off-by: Xueming Feng <kuro@kuroa.me>

You seem to have forgotten to CC Jakub and Paolo which are also
networking maintainers.

> ---
>  net/ipv4/tcp.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..831a18dc7aa6 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
>                 /* Don't race with userspace socket closes such as tcp_cl=
ose. */
>                 lock_sock(sk);
>
> +       /* Avoid closing the same socket twice. */
> +       if (sk->sk_state =3D=3D TCP_CLOSE) {
> +               if (!has_current_bpf_ctx())
> +                       release_sock(sk);
> +               return -ENOENT;
> +       }
> +
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 tcp_set_state(sk, TCP_CLOSE);
>                 inet_csk_listen_stop(sk);
> @@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
>         local_bh_disable();
>         bh_lock_sock(sk);
>
> -       if (!sock_flag(sk, SOCK_DEAD)) {
> -               if (tcp_need_reset(sk->sk_state))
> -                       tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED=
);
> -               tcp_done_with_error(sk, err);
> -       }
> +       if (tcp_need_reset(sk->sk_state))
> +               tcp_send_active_reset(sk, GFP_ATOMIC,
> +                                     SK_RST_REASON_NOT_SPECIFIED);

Please use SK_RST_REASON_TCP_STATE here. I should have pointed out this ear=
lier.

Please feel free to add:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
in your next submission.

Thanks,
Jason

> +       tcp_done_with_error(sk, err);
>
>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);
>         if (!has_current_bpf_ctx())
>                 release_sock(sk);
>         return 0;
> --

