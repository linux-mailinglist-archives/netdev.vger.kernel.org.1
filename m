Return-Path: <netdev+bounces-158781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A000AA133A8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C893A4F8E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A392158520;
	Thu, 16 Jan 2025 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc9/3Q4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AD15252D
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012017; cv=none; b=NPlQvbNzCtVDoCbPZ3hvu28/O/2XbcZpNZc2ZKVSQPDyTvOSKdYjyQg9HzI9iMUzPoI6MPNZuJ4xjymG1K0yGEx9cys7uW0fUFrSmH5Ba2KesX0SW8p7DgTyixHJWamszqffy62R04vy0n9xAezoGA9Hs+Opc1zloHT3+nnI6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012017; c=relaxed/simple;
	bh=ESacip85XpkOs0DkY28MfdJwiW3KZs1VDKV1zXLzzpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXIYoN6pLFlHHKfvZ8GzlDmc034UG8BuW7nhhFqJVdOPf6SlpGlizAu4WY2LFGU8DcIuezgFHM9rGPfvjRu8Ewq30y/ZSS6dCXpc/+cei1CePU5ogd7Pe73yLo9i8ua2QeU6iXS+/7Gyys41GK8jXKqDiT6u0L1Mg9ZmlDdqi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc9/3Q4s; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce7f6fdd2aso4312145ab.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 23:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737012014; x=1737616814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FcshOtWMBkMySWWFn1Ikcy/FPGfcFqtnyxN6DDMBZ8=;
        b=hc9/3Q4stOFnX+IS2vc9uyVKU8G1HMkL1Qz/l7WwgNmWEcaslbiixhLMZYhJYQMVGP
         xsxmuY3IaQkwaBGB4yZ5UcWUd1RyywlNaDT+NQ2Nc49xxnlKCzfAn0zl6yQjxOr/kvnZ
         cOcTwnDqID15Uxo6mKjECvMLqBXEXWJ3LtHdiEXMPExZbnojdMDc5oRcKuV+nldyddPH
         mDRKHGJOWGchI1UO7DtOhG6ECtWEAf4MhdzWmwyVPPyP79Qwp7SGykDO+eN01yrdzPRA
         cxiklGr+9sr9qwe8dEaJ/TVoxRlmgC/kdoyUQf+gJln4/LeDzBClYNLMl3bFChWYNLC9
         Ug7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737012014; x=1737616814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FcshOtWMBkMySWWFn1Ikcy/FPGfcFqtnyxN6DDMBZ8=;
        b=TPEWixveb7q5TKdPyY0aiwHjEa4WGdeNHJBSJwRtFZ8QTBPEaO63xL/aSTyXLPNR0f
         U87nnxoCWHSu6GcXMSX3Njw64wdw2EGwMARoB/Woqk5xvEDOfzniR73qofyg3iGt3f96
         r8alVGtN31fu028V88WffQvhr5AO19cEtsCA3xfoUM2x7nrQNp0yx8TMY9lOz2OtmvHz
         dcGED7O/9tmQJv5klNFyHcW189RA5mlLXELfUSnD2Mnb7bi8sRNYeyGBrFbVzyHYT0gf
         Ie7p/mVviZ6VZ6yVdvE7+xn9lVdf4ldleExzedJo2pfZjy2xu2oMNTwYD1HdphC+BPfF
         6C/g==
X-Gm-Message-State: AOJu0Yw50/wZttao331KOh7lID+inhHBaZTzPgPFQjG6G7DHG3Q+zWeG
	cA4HoU7P+JyTnVspyuUkXZ1XIQd6WTEOUxtmP0pj1aZgzreme75Gz0b8DU5oitsv9O+LwOAU12e
	8ijcaLzEY/bONOLtvLtaqtmVaOHI=
X-Gm-Gg: ASbGnct7Mx6cdUMIXILYNhOinKzjX8c2RoIKKjzPaZBn+ty7QuVUPSWeYhglNRA6yS3
	asznw/HwN6d7TGgb+cNEIQMOIxvEHY1na/nVzQA==
X-Google-Smtp-Source: AGHT+IF+Y1BTcHtbhNSfXODH5OK5bOsGoVC5eUJTQ1JHDMJ0geWV+ugXsZhPq7DCOLnEa6KA1xd8wRrzQ7NqNP8mE/M=
X-Received: by 2002:a05:6e02:198b:b0:3ce:8e89:90c2 with SMTP id
 e9e14a558f8ab-3ce8e89bca1mr29913025ab.13.1737012014597; Wed, 15 Jan 2025
 23:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com> <20250115010450.2472-1-ma.arghavani@yahoo.com>
In-Reply-To: <20250115010450.2472-1-ma.arghavani@yahoo.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 15:19:37 +0800
X-Gm-Features: AbW1kvbCuFC4LCH2IuxwsvsOh0_io4N_XVj-HDX7xLfqwZyf1gCPNyPEkaWsvkg
Message-ID: <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, edumazet@google.com, 
	haibo.zhang@otago.ac.nz, david.eyers@otago.ac.nz, abbas.arghavani@mdu.se
Content-Type: text/plain; charset="UTF-8"

...

> potentially degrading TCP performance.

Interesting point, I try a few times but don't see the degradation of
performance actually based on the limited experiments I conducted.

>
> The issue arises because the changes introduced in commit 4e1fddc98d25
> ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
> moved the caller of the `bictcp_hystart_reset` function inside the `hystart_update` function.
> This modification added an additional condition for triggering the caller,
> requiring that (tcp_snd_cwnd(tp) >= hystart_low_window) must also
> be satisfied before invoking `bictcp_hystart_reset`.
>
> This fix ensures that `bictcp_hystart_reset` is correctly called
> at the start of a new round, regardless of the congestion window size.
> This is achieved by moving the condition
> (tcp_snd_cwnd(tp) >= hystart_low_window)
> from before calling `bictcp_hystart_reset` to after it.
>
> Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
> Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> Cc: David Eyers <david.eyers@otago.ac.nz>
> Cc: Abbas Arghavani <abbas.arghavani@mdu.se>

As to the patch itself and corresponding theory, it looks good to me
according to my limited understanding of the hystart algorithm :)

After this, we can accurately reset at the beginning of each round
instead of waiting cwnd to reach 16.

Note that tests about big tcp like in the commit 4e1fddc98d25 are not
running on my machine.

> ---
>  net/ipv4/tcp_cubic.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178..76c23675ae50 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 delay)
>         if (after(tp->snd_una, ca->end_seq))
>                 bictcp_hystart_reset(sk);
>
> +       /* hystart triggers when cwnd is larger than some threshold */
> +       if (tcp_snd_cwnd(tp) < hystart_low_window)
> +               return;
> +
>         if (hystart_detect & HYSTART_ACK_TRAIN) {
>                 u32 now = bictcp_clock_us(sk);
>
> @@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
>         if (ca->delay_min == 0 || ca->delay_min > delay)
>                 ca->delay_min = delay;
>
> -       /* hystart triggers when cwnd is larger than some threshold */
> -       if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> -           tcp_snd_cwnd(tp) >= hystart_low_window)
> +       if (!ca->found && tcp_in_slow_start(tp) && hystart)
>                 hystart_update(sk, delay);
>  }
>
> --
> 2.45.2
>
>

