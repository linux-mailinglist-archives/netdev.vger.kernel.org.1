Return-Path: <netdev+bounces-110458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CB492C7F1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F6B21492
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A25010FF;
	Wed, 10 Jul 2024 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQyJBtdn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE98F45
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574890; cv=none; b=St2sWq+Uqvx6tk9PvTmV8Km3SVfj7BHfbZH10JiFk4kJBcuP/UPW6LeZ69yRyCNSm8Qyk9yUQ8FKdgdROQez47jkL81m2ZD0ZqpxcOyFPwWELSFuQVmKH88mK0bstRqCvKCjnGw4oxwGt9mDtfhYf/x+srWu6rPDAL5ytM5QuNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574890; c=relaxed/simple;
	bh=vwal4VpjrXnXzfSEMVeGoDUCkiT5wR7iGLcEH2X++3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhG2I9fCpR8eNeyHp9YugyX/BrlYRlJZXiZgfJNw0fj/ldncuHQjKr1GMkSb+sAwzywIYs+8IOKW9aa7COvaMK2zF9a6dj+sztESLGQGAbFmfl2aemTYH3ZupL8E2aiGDZRhxyk4MiJszVDcDOxg5mQC4rT+/8MKHesEiQP1Kq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQyJBtdn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so551661a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574887; x=1721179687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBDhSNC9/0HyDfF5noAhSDq9q6cRts6TFgWJl4GqalQ=;
        b=dQyJBtdnKexsYtN4DvcJImM43pO3lDTSswFk1KH9Jg6XlKct+bzg7n8DDz223BmLbw
         0KmrprtfPQfdRccDrgcmFKx0i/aQzYPPNYrvV1WyHLAY/0wrMCdNCIXivohBiPQdODOt
         SaxszsdsXxXw7e/KBSGod6aKnBYNESCC1gKvecbaGr70CQww/kDNKF8RaeJ2XmQ/g/Dq
         Qj9wXfs91oPf/kES7QrzrRIrJm/0gpwyueJiqRH/U4EfPMVNYUbgz6+lBHxSR1SG3RrV
         vWaPIqAUS/eRNxoLBbUYIqQqrSXuNPgn+pUT1WAuYZzZjqBWVOQdjklpj5lapyBRPA36
         L+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574887; x=1721179687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBDhSNC9/0HyDfF5noAhSDq9q6cRts6TFgWJl4GqalQ=;
        b=qQ8Dk4HsRcsdnQcDkPps2YORFF40sY5bFruIncX6jg4ljvaP3qTkw7cieYdi9WAd/J
         4E5er3k5Tu6IU/jF95GRGckG8yMKVNBE5CO9Ir78Hdk/45w0PUJ+iFSV49nE/nXW17hD
         bosfSqSQdbNFK/CO4TsY3q7BvZMeAiC1Ct6loiPArOBQw5jlRCkVP1+zIFvJiJZBvAcW
         7LvYDO7GVYbUnI886rsHaAKc3Wp7CygO1OLpFUOxM3OGKqBeOEBOgJbCZjlMemM8rXxX
         X0LR4tjcpdF+xZ+o2XnIF2OR0QMrOt4QYQkDS9HiA02eizd00oYOIGIUKHYmBcvEwsLV
         GeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcReizZzSZjaAhyygTc6bVNeOIdSlx+Pt9pXPw0v5UX5GYBCwoXyyVyzczOREduQVhULpWkBQTkGJLwBqbZxaF5cyDgwc6
X-Gm-Message-State: AOJu0YzIZghD5TaBBeE9NBxQBOK8KAsGMdPCyU3e/QWZA3ADKrpfTRKA
	Oqiyhk0a61+TB1HhAR4U/yCVNZB3NxxaKTVMhj7dd8Aebi3kc8jkJJZk4mnYhZtBFv917rld0Y1
	AjOMiSrIeqHm+af9gKlPMbtwDyAuTOeZL
X-Google-Smtp-Source: AGHT+IEPKR2ZpEteugHWZEpX8kXIWIeH2wMBr8I+59aft8gtiz5Hb6WmdH2X145tjkX7Hv0ffcqA/NVuGwsWi6I8KHg=
X-Received: by 2002:a50:ee94:0:b0:58c:10fd:5082 with SMTP id
 4fb4d7f45d1cf-594dcf6f443mr2803040a12.10.1720574886542; Tue, 09 Jul 2024
 18:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710001402.2758273-1-edumazet@google.com>
In-Reply-To: <20240710001402.2758273-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Jul 2024 09:27:29 +0800
Message-ID: <CAL+tcoDjXSbfAzAVmjQiAdxdBz_-0zXnj_j76wPqb=xEx7755w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: avoid too many retransmit packets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Jon Maxwell <jmaxwell37@gmail.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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

Interesting case. Thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

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
>

