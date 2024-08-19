Return-Path: <netdev+bounces-119626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBAD956636
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F9D1C21701
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA736155A25;
	Mon, 19 Aug 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3h6PjxrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B111CBD
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058060; cv=none; b=X0kxUxQP2pINB7RImMWg28AWsrueZDWcx8h8sUZNIByFJvnKF08LwLialQZfUR7qp75pFHVI/uMO57QowgXruE7p/SCueSKdGQY2QQNNkAtaSdFkTHe7s14J/TQltAvJyRXkSw5irRrupKfJFTlzqgMhLoMG89z84JnJmTguZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058060; c=relaxed/simple;
	bh=w/7zpPS9j0OEaluTZGUn6mY/BF2C9s8gP8829sX8FbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/BjT2atS3hTUGCpZadC7MqROgfYFTINcVm6hLfJycuLpDkt/Ewb+NHdIAkj5Wx2SjPTxQ58sgQ6Gwq8iam+eM8eA3UTviTizeLhkEBVPvlFfyzUlgUs5JbYy9IA/b3AN0rE5vPa35sdNfL5/viDxrxusltFR+zSU5X/j6CySGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3h6PjxrM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f16767830dso44556391fa.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724058057; x=1724662857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT+VesBeb84YjmbjzLOMAlCevozA4CVye8szfoZKi6E=;
        b=3h6PjxrMYXH5T30Bl9pMvqOmZn8mUuHmP9cu9IxTJpZaoRmTDB48F6ETqMz1FdlQ3b
         Jt9mrmUvEPXn3g++Qu7iRUZhrkynVLf2rOXbHACy8Nu9oo79uXz1s3D+rEV4aZQdiVk2
         5oHn9FD/tuANiOesiHox4JPp2UfM9unR7CCRM+SKa8PVFmm4x61ZB/x/ojxsBkDSuYy4
         9KbikxjWFsC+F3ShYCMS1TP37+Sg+L/QqdixC1BQi6amufZNUkdYJ1iLisb1AWZf56JN
         BZgaSo0MKHs9EcTK8Vt9amwars45GX2c7AHW80I+WcBNkiIYO5sJYvGgHmfhRrAS5Q3R
         hxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058057; x=1724662857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT+VesBeb84YjmbjzLOMAlCevozA4CVye8szfoZKi6E=;
        b=hPFAF5pefxv5b6eJm8l7Kwq+Xb8z4uhnVbV6I8g/CwD1b/j2UeyAA0yS12KcBKES4G
         AHAbByCM33cVkoF0D7weqZSUu5rxERkUE9BIBq62TBnuIujDK5ZXBDUnSQUE2RDGbnBH
         iZtctyBD3YlwQwCOiM78Xcne4fS8qzEOdWqqwCTHU/c7rVMsUMEQO3A5/4QobmUBHtjG
         bwwJP79LqWBXC1Kvou2ksLzgC2Zzq9s3rMJrAREfWeh1HPOIB2VfR2rFk2+J9J10p9wC
         IT57Wz0Dt+Bz1dxnltKlx4GFTILvqKRovVIiuDDkMIpMku0cwkEl/+ejwc12Z7MKoqMH
         KOdA==
X-Forwarded-Encrypted: i=1; AJvYcCXLdCGbh7CBEJkuKS61m3H8KNHg91TBpF+3dsGYkVkSKlUpK9C6wPGP5TkQCc/w20eEfMo2pMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVhfYh4/TGTyRIJAq4lwJBOT2GjY94AJYtHpMU8BcDHLvTvQf
	xuqxbvQVy6GBzypfy0nWKeHhJWNFlhqd8EjgQPpYNBPwWHGpbCvRxT9LyMLel48Z8D6H/dHnLNR
	gq9VX0Iv4dwjlQW4FAWFYi6hxCyM7dvY4fpUB
X-Google-Smtp-Source: AGHT+IE7zHp0sE4SVQoDpDYqGGJDrXP4ZzgTWGdKOWK4V3tmmg89MqXKKZY+AI6ZGiZvgRuwTiJe8fjU5a3nMtaZ6Y8=
X-Received: by 2002:a05:6512:1111:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-5331c6b01aamr6437292e87.25.1724058056165; Mon, 19 Aug 2024
 02:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-2-mrzhang97@gmail.com>
In-Reply-To: <20240817163400.2616134-2-mrzhang97@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 11:00:42 +0200
Message-ID: <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 6:35=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> The original code bypasses bictcp_update() under certain conditions
> to reduce the CPU overhead. Intuitively, when last_cwnd=3D=3Dcwnd,
> bictcp_update() is executed 32 times per second. As a result,
> it is possible that bictcp_update() is not executed for several
> RTTs when RTT is short (specifically < 1/32 second =3D 31 ms and
> last_cwnd=3D=3Dcwnd which may happen in small-BDP networks),
> thus leading to low throughput in these RTTs.
>
> The patched code executes bictcp_update() 32 times per second
> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd=3D=3Dcwnd.
>
> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
> Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of tcp_t=
ime_stamp")

I do not understand this Fixes: tag ?

Commit  ac35f562203a was essentially a nop at that time...


> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
> Signed-off-by: Lisong Xu <xu@unl.edu>
> ---
> v3->v4: Replace min() with min_t()
> v2->v3: Correct the "Fixes:" footer content
> v1->v2: Separate patches
>
>  net/ipv4/tcp_cubic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178..00da7d592032 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, =
u32 cwnd, u32 acked)
>
>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets */
>
> +       /* Update 32 times per second if RTT > 1/32 second,
> +        * or every RTT if RTT < 1/32 second even when last_cwnd =3D=3D c=
wnd
> +        */
>         if (ca->last_cwnd =3D=3D cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D
> +           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))

This looks convoluted to me and still limited if HZ=3D250 (some distros
still use 250 jiffies per second :/ )

I would suggest switching to usec right away.


diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..fae000a57bf7d3803c5dd854af6=
4b6933c4e26dd
100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -211,26 +211,27 @@ static u32 cubic_root(u64 a)
 /*
  * Compute congestion window to use.
  */
-static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
+static inline void bictcp_update(struct tcp_sock *tp, struct bictcp *ca,
+                                u32 cwnd, u32 acked)
 {
        u32 delta, bic_target, max_cnt;
        u64 offs, t;

        ca->ack_cnt +=3D acked;   /* count the number of ACKed packets */

-       if (ca->last_cwnd =3D=3D cwnd &&
-           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+       delta =3D tp->tcp_mstamp - ca->last_time;
+       if (ca->last_cwnd =3D=3D cwnd && delta <=3D ca->delay_min)
                return;

-       /* The CUBIC function can update ca->cnt at most once per jiffy.
+       /* The CUBIC function can update ca->cnt at most once per ms.
         * On all cwnd reduction events, ca->epoch_start is set to 0,
         * which will force a recalculation of ca->cnt.
         */
-       if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
+       if (ca->epoch_start && delta < USEC_PER_MSEC)
                goto tcp_friendliness;

        ca->last_cwnd =3D cwnd;
-       ca->last_time =3D tcp_jiffies32;
+       ca->last_time =3D tp->tcp_mstamp;

        if (ca->epoch_start =3D=3D 0) {
                ca->epoch_start =3D tcp_jiffies32;        /* record beginni=
ng */
@@ -334,7 +335,7 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct
sock *sk, u32 ack, u32 acked)
                if (!acked)
                        return;
        }
-       bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+       bictcp_update(tp, ca, tcp_snd_cwnd(tp), acked);
        tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }

