Return-Path: <netdev+bounces-113678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C143393F8B8
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303F9B22571
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E41514F8;
	Mon, 29 Jul 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szHfi0n5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FD1DFFC
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264708; cv=none; b=sCzCKK3UPaMGMyWcAO7vN0RVSckE3defKRtJSN1hrjZfBXLlETQhl8ao9pkMjKeSGq907NBiXCxZ3xeNHI6w5EALsfS8HAl1HEXbvOiKCxoyVjcT0mmkZh0V/70FJIFi9vs81NDzQj5yP+fUe+5WJPmXLvCw0naK0jOCqaEaUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264708; c=relaxed/simple;
	bh=KSbGAM2DAkwgY2Dn0za/GQda9kjvgu66l4IfusvMsMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVo6tmUkNxx6unxponlybPLWhKDAAKIt1iYAyiTkJ42H0w0/EYeEqU6TDdXzJOhyJcNVU6q+981jFOKCnwChN2yvEtdrLWMmM88au6Sgk+CwNyxArT34oE1taFSTExZqwV8bmqwxhIAWPrST0mZnCVnDI8D70O6Wz6muBzlHFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szHfi0n5; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928d2f45e2so658838137.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722264705; x=1722869505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NwH4St9z/9E1k+RufrzmvkFMjJeCJZZ2D44LP+r2wU=;
        b=szHfi0n5kVFZQV9Hs2DFBgdIbqCLCIN4Z43w8X1X6T6II0aCJvR3gSiFO1Hmjx10CT
         FUcSLBg4Ol2h4s1jBI1sL7BADxQ6ihepinWESjkyz+FJ4/RoD732rEwhbU6Mb79GSVAJ
         gt8sBG7Il5wJj8rSd+ay/tNcDro1nzQ7r7L1vAW2Wuwu+SaG84qa09E0Z10fyg2JC0/3
         rsQaxmLkGqFLJTZgy2lQxKV5je1ryHvF1XKlb+2HOgPL15t8pe2NjOyCVjh86DKMSeMM
         j1k/kjWuZfK/MJYaL01lBwvvXAWtM7p2mVeU/1H6heTCteNCVt6pHWO0kRL6x73YtQqb
         xm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264705; x=1722869505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NwH4St9z/9E1k+RufrzmvkFMjJeCJZZ2D44LP+r2wU=;
        b=sJstKJi14ZXLwaDrr8AwpDcVB+nbizH5hZIBJbg+bihfTc4ISszK01kVK649NaD/kw
         ulRjQ1JNe+NV8pKCnFbyrkDnQrTD5aJY5eafLwV3Zy9ZUQiEPNlT3K+CUD5Y2bIBF7N/
         sv/sZ5+S4Q5uOifVrUWCZv2U6PaU5S5gVWCKCT+xF7Q12lmndp2dg2VPqLu7z/xXA2+l
         siU0Z5KeJWxYjiOSpcMe/Apjw/e51zuTApblbJ+hopHR4Ip6DvZPdFy5Brq5ernZFghf
         4LqaET0VWSYRHp2rDChabgOuIAfp2l+kLpjaY26wKQ0kf6mXIvFDIr4HnXt2HBXiuUuj
         tA+g==
X-Forwarded-Encrypted: i=1; AJvYcCW3upgt60nupN8VQRmZZV71irgpXjewFfDykFC+f6wcnraPprbsLFNq3yft5kxab6XD+/9lyZ84blLEd/9UKPee7Q94LMcu
X-Gm-Message-State: AOJu0YyGPGbWD1BDNioCR1cjdATzlOfQHp2Rgfi3k3xioNkiuSFn5QBi
	Dos7+GaKkrDB9OXfsRUTYjlQK/iVKy2Z+VsR468iqHJiFVn4S6LNbmCGhcZpyTlbS+KcLYoxO+D
	tHKrfTx46y4JP8Ry01RBZ7FY0jmXh6k1WdAvM
X-Google-Smtp-Source: AGHT+IHqnGliaXoEvXZfH7z6bpUyjLVSbLa6P8eDaUgzf/as5SgDQ/XQrzib3BqVdzPe/hjtA6XLQOXhYk6WfCqF0js=
X-Received: by 2002:a05:6102:c8a:b0:48f:a76a:7d with SMTP id
 ada2fe7eead31-493fa1ed67emr9804943137.18.1722264705230; Mon, 29 Jul 2024
 07:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726204105.1466841-1-quic_subashab@quicinc.com>
In-Reply-To: <20240726204105.1466841-1-quic_subashab@quicinc.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 29 Jul 2024 10:51:25 -0400
Message-ID: <CADVnQynKT7QEhm1WksrNQv3BbYhTd=wWaxueybPBQDPtXbJu-A@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: edumazet@google.com, soheil@google.com, yyd@google.com, ycheng@google.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	dsahern@kernel.org, pabeni@redhat.com, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:41=E2=80=AFPM Subash Abhinov Kasiviswanathan
<quic_subashab@quicinc.com> wrote:
>
> tp->scaling_ratio is not updated based on skb->len/skb->truesize once
> SO_RCVBUF is set leading to the maximum window scaling to be 25% of
> rcvbuf after
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> and 50% of rcvbuf after
> commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
> 50% tries to emulate the behavior of older kernels using
> sysctl_tcp_adv_win_scale with default value.
>
> Systems which were using a different values of sysctl_tcp_adv_win_scale
> in older kernels ended up seeing reduced download speeds in certain
> cases as covered in https://lists.openwall.net/netdev/2024/05/15/13
> While the sysctl scheme is no longer acceptable, the value of 50% is
> a bit conservative when the skb->len/skb->truesize ratio is later
> determined to be ~0.66.
>
> Applications not specifying SO_RCVBUF update the window scaling and
> the receiver buffer every time data is copied to userspace. This
> computation is now used for applications setting SO_RCVBUF to update
> the maximum window scaling while ensuring that the receive buffer
> is within the application specified limit.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> ---
> v1 -> v2
>   Update the condition for SO_RCVBUF window_clamp updates to always
>   monitor the current rcvbuf value as suggested by Eric.
>
>  net/ipv4/tcp_input.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 454362e359da..e2b9583ed96a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -754,8 +754,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>          * <prev RTT . ><current RTT .. ><next RTT .... >
>          */
>
> -       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
> -           !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> +       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)) {
>                 u64 rcvwin, grow;
>                 int rcvbuf;
>
> @@ -771,12 +770,22 @@ void tcp_rcv_space_adjust(struct sock *sk)
>
>                 rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
>                                READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rm=
em[2]));
> -               if (rcvbuf > sk->sk_rcvbuf) {
> -                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> +               if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> +                       if (rcvbuf > sk->sk_rcvbuf) {
> +                               WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
>
> -                       /* Make the window clamp follow along.  */
> -                       WRITE_ONCE(tp->window_clamp,
> -                                  tcp_win_from_space(sk, rcvbuf));
> +                               /* Make the window clamp follow along.  *=
/
> +                               WRITE_ONCE(tp->window_clamp,
> +                                          tcp_win_from_space(sk, rcvbuf)=
);
> +                       }
> +               } else {
> +                       /* Make the window clamp follow along while being=
 bounded
> +                        * by SO_RCVBUF.
> +                        */
> +                       int clamp =3D tcp_win_from_space(sk, min(rcvbuf, =
sk->sk_rcvbuf));
> +
> +                       if (clamp > tp->window_clamp)
> +                               WRITE_ONCE(tp->window_clamp, clamp);
>                 }
>         }
>         tp->rcvq_space.space =3D copied;
> --

Is this the correct place to put this new code to update
tp->window_clamp? AFAICT it's not the correct place.

If a system administrator has disabled receive buffer autotuning by
setting `sysctl net.ipv4.tcp_moderate_rcvbuf=3D0`, or if (copied <=3D
tp->rcvq_space.space), then TCP connections will not reach this new
code, and the window_clamp will not be adjusted, and the receive
window will still be too low.

Even if a system administrator has disabled receive buffer autotuning
by setting `sysctl net.ipv4.tcp_moderate_rcvbuf=3D0`, or even if (copied
<=3D tp->rcvq_space.space), AFAICT we still want the correct receive
window value for whatever sk->sk_rcvbuf we have, based on the correct
tp->scaling_ratio.

So AFAICT the correct place to put this kind of logic is in
tcp_measure_rcv_mss(). If we compute a new scaling_ratio and it's
different than tp->scaling_ratio, then it seems we should compute a
new window_clamp value using sk->sk_rcvbuf, and if the new
window_clamp value is different then we should WRITE_ONCE that value
into tp->window_clamp.

That way we can have the correct tp->window_clamp, no matter the value
of net.ipv4.tcp_moderate_rcvbuf, and even if (copied <=3D
tp->rcvq_space.space).

How does that sound?

neal

