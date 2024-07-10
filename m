Return-Path: <netdev+bounces-110460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63992C804
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407051C20FC2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECAF4404;
	Wed, 10 Jul 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZeI2qu2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9773D7A
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575823; cv=none; b=AFUS55Y70L7EqAuNP2AL4ftOJi+LKFqJJHuKFgT0KA6xoBIVG2Z7cfzm6NZnFlVovtQEcaDm233twnEGQi/dKr67u6xw7Tmg70wrNCgMiu7haRzI+PD45KPUhTe7cN67i8FLgATGq3A7/w3x/NIbywVUXLPOJn/FAg0lgu3/6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575823; c=relaxed/simple;
	bh=ro3B0XF5Vwmqud8Db2GrYalj91q0aeKXDzIGjYBOlg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGvRdDJWrv06ZPMXj3P/yNgc8+TFw4CSXDcjOxGic4a41KHEVkE9otGv4rOAd7WJPy7xV3dM3eR8coyrrHL2C2vj2/0IbZtLSKvI4A0Tu/3q3dMnk/ni9nHJESga4yF9NyJe1gG/zF4mf737oWTBMHeNaYjHi48f9JyP1QpZtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZeI2qu2; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c74f6e5432so447929eaf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 18:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720575821; x=1721180621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kxjEBTz33fqA1JIXGeLTCIuleSwAWjrrWPoldPGEaQ=;
        b=FZeI2qu2GAe/SQEdtL0OAZmmFbwFI0m7kSAXthDtnhwATrO0Scl6/DB/saGrePbSg1
         24c9wwPgG2zJFFO234gD/RN4qrXKe+JS40rt3n6b6Yk7UtWvL8RwEB0W4C52Eqsj34Ii
         aZlEVuUHnyOosgpcyog4RavTfXW+6aVnitP3V8OSwvBPMvjbfqBf9EZfe1v+/UBGhVlo
         Z9J0svJvLnNPoUSjocZsgv2osge1t7iTo7juGw2r5JWp5KZrBKgTQBFotGNdVdLPQ3sh
         AnpI+G5KABOWBhoLRf0SU58VvPQVw5V1YjPrHGgzTi6DnfB0Ok8podST9sm4FkE3oZUU
         jB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720575821; x=1721180621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kxjEBTz33fqA1JIXGeLTCIuleSwAWjrrWPoldPGEaQ=;
        b=kDwGHT0abWbqbcJvd9AxGtn7dyYz6CshS0NcprUlHSyx93kCdaNS4qUjJ+25KtZ/Ma
         tos+9VMxijEz5gyZzdq0wOFUj3Xe1bLiNvhXCvX1E5qSCwK64+8bl2rpwhN/v5b11SIV
         n7kmFwGrDyaw/rj9BHlgN9ovYULEwBYlkovblx7oKrQKJK9qLmhiRAcC1/68i72zkQrV
         uFgcPD/b48FWUHmhyifrsZD9TdoycY5N+LD8iypcDr4igEaFJ3rjJ6UtGxYmlK1wRI2f
         xcsjWc77rTrRmS/agoP5agug9VHCmuVzptQOxga5Uf9syTTSHe24aX74upziWMRXBhFY
         DJrg==
X-Forwarded-Encrypted: i=1; AJvYcCVeiu0SMlQBB/qN3lUxKblenQaPHSKC96l77o3NKtds39MXia3fsTVsGe+LHI4ZuWq+w6/XQ46iXxtNVDKhAiwWkcOLZm/w
X-Gm-Message-State: AOJu0YwLqC4r8rOeUehQzxJ0jyFwUhSnXU9S8nUKwV3QvwqI7TPHK83s
	T0C94EmZ74Z0U0RG9gAZU45FcI9HZuKrxCcksIEP28jjWtX2AAxKUbVWJE912v6kcnV8dzsu1jx
	e8ok+e1fLo7kak1zfr7sIlmwC+qQ=
X-Google-Smtp-Source: AGHT+IE49PI7Uq77sWK0yAZyFJT/NZoJ3dUeHa0u34TI4VHcFRt+bA7vXeLg88WDqVmqlAj6Gd2FP6rSNbNacwvSn98=
X-Received: by 2002:a05:6870:d38e:b0:24f:cddc:ccff with SMTP id
 586e51a60fabf-25eae81a20bmr3457833fac.21.1720575820857; Tue, 09 Jul 2024
 18:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710001402.2758273-1-edumazet@google.com>
In-Reply-To: <20240710001402.2758273-1-edumazet@google.com>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Wed, 10 Jul 2024 11:43:05 +1000
Message-ID: <CAGHK07CjoeiUgNHrtY1+Km92rWft8nSONUnkzmRK4gOWW8npyQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: avoid too many retransmit packets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> If a TCP socket is using TCP_USER_TIMEOUT, and the other peer
> retracted its window to zero, tcp_retransmit_timer() can
> retransmit a packet every two jiffies (2 ms for HZ=3D1000),
> for about 4 minutes after TCP_USER_TIMEOUT has 'expired'.
>
> The fix is to make sure tcp_rtx_probe0_timed_out() takes
> icsk->icsk_user_timeout into account.
>
> Before blamed commit, the socket would not timeout after
> icsk->icsk_user_timeout, but would use standard exponential
> backoff for the retransmits.
>
> Also worth noting that before commit e89688e3e978 ("net: tcp:
> fix unexcepted socket die when snd_wnd is 0"), the issue
> would last 2 minutes instead of 4.
>
> Fixes: b701a99e431d ("tcp: Add tcp_clamp_rto_to_user_timeout() helper to =
improve accuracy")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jon Maxwell <jmaxwell37@gmail.com>
> Cc: Neal Cardwell <ncardwell@google.com>

Nice catch Eric. Thanks for fixing LGTM.

Reviewed-by: Jon Maxwell <jmaxwell37@gmail.com>



> ---
>  net/ipv4/tcp_timer.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index db9d826560e57caf8274d1b7253c7af4dd7821a0..892c86657fbc243ce53a93915=
7b77f1fe0410097 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -483,15 +483,26 @@ static bool tcp_rtx_probe0_timed_out(const struct s=
ock *sk,
>                                      const struct sk_buff *skb,
>                                      u32 rtx_delta)
>  {
> +       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> +       u32 user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
>         const struct tcp_sock *tp =3D tcp_sk(sk);
> -       const int timeout =3D TCP_RTO_MAX * 2;
> +       int timeout =3D TCP_RTO_MAX * 2;
>         s32 rcv_delta;
>
> +       if (user_timeout) {
> +               /* If user application specified a TCP_USER_TIMEOUT,
> +                * it does not want win 0 packets to 'reset the timer'
> +                * while retransmits are not making progress.
> +                */
> +               if (rtx_delta > user_timeout)
> +                       return true;
> +               timeout =3D min_t(u32, timeout, msecs_to_jiffies(user_tim=
eout));
> +       }
>         /* Note: timer interrupt might have been delayed by at least one =
jiffy,
>          * and tp->rcv_tstamp might very well have been written recently.
>          * rcv_delta can thus be negative.
>          */
> -       rcv_delta =3D inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
> +       rcv_delta =3D icsk->icsk_timeout - tp->rcv_tstamp;
>         if (rcv_delta <=3D timeout)
>                 return false;
>
> --
> 2.45.2.993.g49e7a77208-goog
>

