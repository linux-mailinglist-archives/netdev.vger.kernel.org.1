Return-Path: <netdev+bounces-146835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114229D627F
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73209B26595
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103F71DF73A;
	Fri, 22 Nov 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s//bAj9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B241DF725
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293888; cv=none; b=mqw0XLwGjKPx8edJrvBwZJTNybSGL0eBcJBonwuJuQQrNFTY4LzmxtIG+1soc9qSO4I+3QguJUhm+yu1wwPJL0ffb725Egg+V5mG7RkDZJnXlXhGD43kREtMLW09U2sYokExhkt21jf5e8/yRDG/mOizlG3MRUr4QzaO6QHJC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293888; c=relaxed/simple;
	bh=VvA6MI6DHMqhZqQToztYS0AJPxXp/UyRcuWOX93oXSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwoxKTDA0PoCx9+bmXa86nsdk4luvS4IElxAwTsxiGotDRLNRsQ6lTkhN+XA4k+9uHxKNwWpn51kf6bq+Dom/ek2fozp7dsGDN9qHJH/EM29KbBMzAlPYiL7cXj8QV1BJ1cRm+kd4Jm2Nr1Yu/9cf12pDUw2kMmra/O8WubxZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s//bAj9B; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfd3a7e377so3084678a12.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 08:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732293884; x=1732898684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d0pR2lErJFhGW5JYLVTt1M7sixp7bLkth135lWgw3Q=;
        b=s//bAj9BX3jyWQ+LKJWgoqfXjzjBRHQTFWOWArDSj5PQsQ1Dse795yIt14/D6yzraq
         OFPNLDHKwgeq5o1Z5zZbzjOv5e2m4TiYlKzKjv0fxX7u+mlvZBn2NG4IHdHgdCtZPQl5
         +kmCfnVjSxdkbaoDDP4yk+mI8R7eDd5cuCmNnnN4nPmI+WjeFC9z5QLmk/ACrrgaWJaL
         ahwMfhgBbmEyTEtWZdv9BrdWrQqeQDegOp8YkRK11FFD5l4EVBgFXHPiPGFgDU4TQjuU
         ZTaWM0E83C2Ia18V67omNa3crqVJ1r0xKGKiKOC4vUD2Ml8zIaJEfpRgkjXRpzQTZqGX
         ulCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293884; x=1732898684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d0pR2lErJFhGW5JYLVTt1M7sixp7bLkth135lWgw3Q=;
        b=tOwEmWZK6VrMUUYwtbW8V4+gVARrGicy6kRASf4IOr+t4F3aCWvRwbDr3IGjYDqDY7
         SbG6j/d1kGeoM5qlLH1WhV2H6oDm6vx7AjZil+iw6nOn/HrsmfQ2nOa7jMVUl0OMboJo
         zfwQH0UdCg0w2EzcBMP7AeI19pGhMhlvWsAYn1A9ZV1GMRJkSoHc4xqHNDGF3RhTkPg4
         638kBDcLJIcQLnQHvkTpwVL4gBS3FC7aPq/e/g6nuJVK+sWXqwCjPZqYziy1lsXi6JzH
         GZEvBdjzNw48I4CDa+C+AB7Ivbi8U6jzS5kYqLeVhJGwVx0rPIVLwgV7qwg9rTd9PbFN
         vdsA==
X-Gm-Message-State: AOJu0Yz8qaO3OCNrqlMVjsGomwrmtaNq6C/+GIoogJpH8hGSxkNChzAs
	vREvXO+0QrCheX7JaUAGeRsP1fcdE+ZPqrfPgAJm7ybRZa4MREJ1aNHTcOa5eAcabTgUX5XClgp
	Z6zb+qtSDL7HF9jVObMPbkwgEH21GFngET8zW
X-Gm-Gg: ASbGncs42fwhLZOuBOiRw3T4lVBXu1g1GGQbrKzG86B1G+QDUrec+7F+yxNU0QzZxlK
	dwQRSX3EzMlYFq1I3SgSKb330JCOapg==
X-Google-Smtp-Source: AGHT+IGcPlzkZ3PyDSUzWV3Kj+QmGM/kj5s2wAAI8F9d7zpAT9B9AXi3L/mFNXWwSOtalAUtm5/jap4f8LUJO4IAqqg=
X-Received: by 2002:a05:6402:35d6:b0:5cf:e402:572e with SMTP id
 4fb4d7f45d1cf-5d0205f4738mr2698610a12.11.1732293884427; Fri, 22 Nov 2024
 08:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122162108.2697803-1-kuba@kernel.org>
In-Reply-To: <20241122162108.2697803-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Nov 2024 17:44:33 +0100
Message-ID: <CANn89iKBUJ6p56+3TRNB5JAn0bmuRPDWLeOwGmvLh5yjwnDasA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: sch_fq: don't follow the fast path if Tx
 is behind now
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 5:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Recent kernels cause a lot of TCP retransmissions
>
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  2.24 GBytes  19.2 Gbits/sec  2767    442 KBytes
> [  5]   1.00-2.00   sec  2.23 GBytes  19.1 Gbits/sec  2312    350 KBytes
>                                                       ^^^^
>
> Replacing the qdisc with pfifo makes them go away. It appears that
> a flow may get throttled with a very near unthrottle time.
> Later we may get busy processing Rx and the unthrottling time will
> pass, but we won't service Tx since the core is busy with Rx.
> If Rx sees an ACK and we try to push more data for the throttled flow
> we may fastpath the skb, not realizing that there are already "ready
> to send" packets for this flow sitting in the qdisc.
> At least this is my theory on what happens.
>
> Don't trust the fastpath if we are "behind" according to the projected
> unthrottle time for some flow waiting in the Qdisc.
>
> Qdisc config:
>
> qdisc fq 8001: dev eth0 parent 1234:1 limit 10000p flow_limit 100p \
>   buckets 32768 orphan_mask 1023 bands 3 \
>   priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 \
>   weights 589824 196608 65536 quantum 3028b initial_quantum 15140b \
>   low_rate_threshold 550Kbit \
>   refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
>
> For iperf this change seems to do fine, the reordering is gone.
> The fastpath still gets used most of the time:
>
>   gc 0 highprio 0 fastpath 142614 throttled 418309 latency 19.1us
>  xx_behind 2731
>
> where "xx_behind" counts how many times we hit the new return false.
>
> Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qd=
isc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> ---
>  net/sched/sch_fq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 19a49af5a9e5..3d932b262159 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -331,6 +331,12 @@ static bool fq_fastpath_check(const struct Qdisc *sc=
h, struct sk_buff *skb,
>                  */
>                 if (q->internal.qlen >=3D 8)
>                         return false;
> +
> +               /* Ordering invariants fall apart if some throttled flows
> +                * are ready but we haven't serviced them, yet.
> +                */
> +               if (q->throttled_flows && q->time_next_delayed_flow <=3D =
now)
> +                       return false;
>         }

Interesting... I guess we could also call fq_check_throttled() to
refresh a better view of the qdisc state ?

But perhaps your patch is simpler. I guess it could be reduced to

if (q->time_next_delayed_flow <=3D now + q->offload_horizon)
      return false;

(Note the + q->offload_horizon)

I do not think testing q->throttled_flows is strictly needed :
If 0, then q->time_next_delayed_flow is set to ~0ULL.

