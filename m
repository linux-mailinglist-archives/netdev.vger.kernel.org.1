Return-Path: <netdev+bounces-117101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A394CAD6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE55028166C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9616D338;
	Fri,  9 Aug 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVLM7yYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16917BA0;
	Fri,  9 Aug 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186637; cv=none; b=WaWLceCEN3l6Mt8rT8/V1qQiiWrKij06B1sZ70s+JCL6+9aKREQL064+MN9tuFGiIvlndsyA8paVTWHpyaNMNOiQ9IkIuyKHEvPhwZ8dXDO/DJHMzzSAQrSN4N8NK2zQ4Xa295k4777bHHzJUTKn/5CGpyZXsMmgf2EcSH94IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186637; c=relaxed/simple;
	bh=SFwualQUJiCtUYI53Ajwc2qdTB+INbHGk/99fUSxUqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpM13Tr5ml0uE6w8GGt483Kee5ptVP0GrsVGaSvxGsK+BcsKtZkREqAdA+X1IdPXeUxysLmjwu2+fpDblZj2UI5okJkQbXQz2WZlt+U6CXDKK3uZVnbrbPj9aJbboOFHerzXl9wP3GNNMdk1fwm8WbCmU0xsTuv6nulVrJ8l6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVLM7yYH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39b04f0b486so5911675ab.0;
        Thu, 08 Aug 2024 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723186635; x=1723791435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hdjl21mbHZ+eelZloxPA1SUnF5vyXYQa/yQsBlope1g=;
        b=YVLM7yYHkRJgAQFnjiekhuQih8Hx0Om2XzYr+Hcez+LaSiEjm6iIMQn+nGKzmeFTqF
         lDPvrzApQJWQaAcVXPa02k8rFsENL6Ss7WHcmbdY8Caeq9lT8PYWdgJLdn10fcUsqMWF
         6mc/QBcILNYjtrYCAK2YpFHWz5ilTl7dgcYfwYxBHAbW4CXCum7M1oPfUupQLd0Lk+Mm
         uQaLFvEaGY+34dt8sQSB/xY9z8gweWxYp/IEoAAe14l5ObVzQbGYw6F10FZoNxknk8om
         REDOlFwb4zumDHOLqUtfDaf8QvgjyAPlKlrvCToDvmNxLz6+/EdUJDNp9G0Hk6qVdCXZ
         /YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723186635; x=1723791435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdjl21mbHZ+eelZloxPA1SUnF5vyXYQa/yQsBlope1g=;
        b=Baqi5IF1QkxIFOCYRE1MMQ0DFXnXITSWWLp5ob44YaM7WjRoEWLAKEb+sA4UzjHMgt
         pEFgK/GE2m9cHX5oGkm3TvICQ2OA4oUno1RKniuJw+Ucmx3cA4htKxQYk8iIUKd1lVaB
         2mOBRCpTMNanmCq772k0aULz2cnGdJ0xFPEWyHFLFwHPlNGkJEhDE5EgQ3RC5k1Ua72i
         7voRPvF6CUVBG4pyyOO8PnMkdEfroBQKijpKThv4ZqV/HHHuqKhqP6Jp6/wG5prGZKBs
         VsJ1wIM7xLGqPvohoF77bqYrAb7D96w03iejsy+jeWl0HvR5++iHidgCbUi01wX9HyAE
         j4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUYmSpUHnQ2mr8bqCIjgPusegHZ4glrr8DESS//JTCdGXKcnhZ1sVfqHxTDLhjeeFeW3ll1PWuYSUScgFLEfKYWb4JDmEYdA8vY0EXb80KWkk1TcJhW/P6PNlGYjt3oMn4bwxpX
X-Gm-Message-State: AOJu0Yx8LIZFWZYZyTKDQHtHZHtRRCygvBd+15r0E8eLWc4/x5CW1Rz/
	y9SQlKjQFWdUfqc/FrOIlOGNCd6iSu7WcUVkgl2EgUPM6JXrsVvDur4TL8AE41vwEtGS2slwusG
	tBeWCmO+NLllKhi1bKJRwXYwqRiY=
X-Google-Smtp-Source: AGHT+IEz2izZRkLcYNo2xJtEW/bFzw4ieuCrQhVfoFQNRNYIv7ngjLRdvkYgT3FREh5qTrIz8Vcnby8trYg9qpTPt+s=
X-Received: by 2002:a05:6e02:1d07:b0:375:e93b:7c8c with SMTP id
 e9e14a558f8ab-39b74967149mr8366735ab.12.1723186635423; Thu, 08 Aug 2024
 23:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoB7F3Aviygmxc_DhfLRQN8c=cdn-_1QrXhEWFpyeAQRDw@mail.gmail.com>
 <20240806100243.269219-1-kuro@kuroa.me>
In-Reply-To: <20240806100243.269219-1-kuro@kuroa.me>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 9 Aug 2024 14:56:39 +0800
Message-ID: <CAL+tcoAyx56CCDk3hyYzR_K_L=fSNsQYy=d88Qv4eQA0GfJD7A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Xueming,

[...]
>
> Below is the patch changed according to your advice. The test now happens
> after the lock_sock and will return -ENOENT if the socket has already been
> closed by someone else.
>
> About the tests, I have some script that helps me to test the situation.
> But after reading about KUnit framework, I could not find any current
> example for TCP testing. Could anyone enlighten me?
>
>
> Signed-off-by: Xueming Feng <kuro@kuroa.me>
> ---
>  net/ipv4/tcp.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..831a18dc7aa6 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
>                 /* Don't race with userspace socket closes such as tcp_close. */
>                 lock_sock(sk);
>
> +       /* Avoid closing the same socket twice. */
> +       if (sk->sk_state == TCP_CLOSE) {
> +               if (!has_current_bpf_ctx())
> +                       release_sock(sk);
> +               return -ENOENT;
> +       }
> +
>         if (sk->sk_state == TCP_LISTEN) {
>                 tcp_set_state(sk, TCP_CLOSE);
>                 inet_csk_listen_stop(sk);
> @@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
>         local_bh_disable();
>         bh_lock_sock(sk);
>
> -       if (!sock_flag(sk, SOCK_DEAD)) {
> -               if (tcp_need_reset(sk->sk_state))
> -                       tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED);
> -               tcp_done_with_error(sk, err);
> -       }
> +       if (tcp_need_reset(sk->sk_state))
> +               tcp_send_active_reset(sk, GFP_ATOMIC,
> +                                     SK_RST_REASON_NOT_SPECIFIED);
> +       tcp_done_with_error(sk, err);
>
>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);
>         if (!has_current_bpf_ctx())
>                 release_sock(sk);
>         return 0;
> --

I checked the RFC 793 and reckoned returning 'ENOENT' is similar to
'error: connection does not exist', which can show enough information
to the user.

So I think you could try to cook a v2 patch officially.

Thanks,
Jason

