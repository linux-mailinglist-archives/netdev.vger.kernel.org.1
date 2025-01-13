Return-Path: <netdev+bounces-157762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE37A0B957
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175FE3A23AD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74B2451CC;
	Mon, 13 Jan 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GP7Mqv00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55023ED79
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778151; cv=none; b=Ofllpi+1y+UJFQ9wrZxtn8T9bOh8RAEVBgqmcGxDA+rIwea4NT5vA7UNF60wKGvduTHxa9jnudq3zTaB3kFHOTfGD6/F+ryIjgdlZEmws9JrpAFlQWuPc6vz7YdITKBKsfdfAlavRwmvxG/S9J+kmHxPUuuJ2FWMsG6JoCK9iVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778151; c=relaxed/simple;
	bh=42WFtmOYpH+B6QVxEUdZDZJ7XtAX3ccmzl1auUSqKXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDPl1fo7X2+q4VWSerGer9U0dmXbVLBMPY9V2lMoBurRp52cPT38eGK8IIzfsDhijrzH6tOttnsAkw/JBlQXIMRZrTwe1B3ghmEqs/XiJ8P2Wn+c6zEbVTGeVfJGBNKvoUHjd1azl+b2b+yDrZF8rsit80AdBC6+8Uj7eg/9bpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GP7Mqv00; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679b5c66d0so355211cf.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736778149; x=1737382949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUjKUq4JogY2vp5cmbbGYUUrQ5SyoPyCU5UTkEBVOyc=;
        b=GP7Mqv006yWEV82uKW4VS62HQn9L5jJTu8vFhl0wkm5CSX3ifKz8aCv5f/tJ7dUYJA
         cZd0Ph00wt7JMpxCvBfKbWu1twmv8NVZCsk7aj7ojT3r4e9cb8c9+eyhYCeGzo/BNIIw
         7Tt/QJAZewav6t7tcBZGxeV66YSzwP9Wuhr+96OkptqIS+wU34eBskzhUxfRtIM7z6uk
         lLKiCY/6K4suSaRP/lYEsejopGDOcgSa9FU0ySeUNG8Fcvdhi4+lRbp+1h3lc9ALVJm7
         AHb4HcN48iRv1zjXMk2UJZvMHq4GBYanoHi6PKz426A9EqKTtk1im3CWaESteTIPq+dZ
         4xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778149; x=1737382949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUjKUq4JogY2vp5cmbbGYUUrQ5SyoPyCU5UTkEBVOyc=;
        b=o3/emNzcx6bna9ZHFf7+xIwOLrX5ep4txFPcN7a8boyTu7xYwcLjoAAq8ojIfvd2Df
         5718PrwlDRfLQkF3Jp1nLi0HJK74DDQ91grYpTFXfJnEN4B3M6UClbRvFccHcNAQJX3N
         g1VTcrZIngpM99NXiCPMFwrJh67ANRwDmUDmFgAlC8AMGmx+rVs/zQ5NU46n5wKuLW8G
         RmyNLY+I8BSSlk3SsnbHPd8jhJBdmADzl8kZwYk6+gb+oCT2M7RBGNxQbzclRDpg0RxF
         8fEXN6Zuhk+XxBVvjA2Mzz+iSpm1DtiDwwA5wsYdciEtegHan4dWassFIyc/4VGtHFow
         ioyg==
X-Gm-Message-State: AOJu0YxM3BOYHjsc9QFYryYXJX85mWzJSyByw5svSk1m0ZDQiijud4l9
	IM0fvjZ92GOm+mctpdcvlLH1doNnkjEopmO8Gj1vZLQLVqNhIJGGS/rh68nSELThL24pPzwh2Iz
	sffqNgjCgEYzjFYruJnLm534obpTUe4Plxdi2
X-Gm-Gg: ASbGncs0ysc622OFuJWUspN/11mTv6t2+emn5BJoEc2G2vJcwiMDPTM60lKrPdelE7T
	2fC48PEZYDfE62fu/TnF19ao8Ij6VCDAIzOqUHsaf0GEQlINvOR3gXQyhhEbgnjqaTyIfTxA=
X-Google-Smtp-Source: AGHT+IGNJU7dDhY78ICl54bq1QHZZceU5kBRdtXuVngYElcvmswgDjFz2X2EBnaaI+o2WniJ6GYjEgUw83xpfwfOM+U=
X-Received: by 2002:a05:622a:118f:b0:463:95e2:71f8 with SMTP id
 d75a77b69052e-46c89daa623mr10024341cf.15.1736778148531; Mon, 13 Jan 2025
 06:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113040656.3195-1-ma.arghavani.ref@yahoo.com> <20250113040656.3195-1-ma.arghavani@yahoo.com>
In-Reply-To: <20250113040656.3195-1-ma.arghavani@yahoo.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 13 Jan 2025 09:22:12 -0500
X-Gm-Features: AbW1kva6WsVqUvqIvI7Lcj4acl2NiaPdoAzU-heGiJv0KTcLprCieapISfJv66g
Message-ID: <CADVnQy=AhO3gUMQ2NcVWzK-9bW13DfsXWf7-s9TktSR4wryYHQ@mail.gmail.com>
Subject: Re: [PATCH net] Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart
 ACK train detections for not-cwnd-limited flows")
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, haibo.zhang@otago.ac.nz, 
	david.eyers@otago.ac.nz, abbas.arghavani@mdu.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 11:11=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:

Thanks for sending this patch.

Regarding the proposed commit title:

   Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train
detections for not-cwnd-limited flows")

Please move this Fixes: part to be the first footer, just before your
Signed-off-by: footer:

Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train
detections for not-cwnd-limited flows")

For a patch title, please consider something like:

   tcp_cubic: fix end_seq to update for all cwnd values

Please use "git log" to take a look at example commits in the Linux
history to get a sense of how footers are used.

> I noticed that HyStart incorrectly marks the start of rounds,
> resulting in inaccurate measurements of ACK train lengths.
> Since HyStart relies on ACK train lengths as one of two thresholds
> to terminate exponential cwnd growth during Slow-Start, this
> inaccuracy renders that threshold ineffective, potentially degrading
> TCP performance.
>
> The issue arises because the changes introduced in commit
> 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for n=
ot-cwnd-limited flows")
> move the caller of the `bictcp_hystart_reset` function inside the `hystar=
t_update` function.
>
> This modification adds an additional condition for triggering the caller,
> requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also
> be satisfied before invoking `bictcp_hystart_reset`.

Please combine the previous two paragraphs so that it is more clear
that "this modification" refers to 4e1fddc98d25 rather than your
commit. And please reword this as "This modification added", to make
it clear that the modification was in the past.

> The proposed fix ensures that `bictcp_hystart_reset` is correctly called
> at the start of a new round, regardless of the congestion window size.
> This is achieved by moving the condition
> (tcp_snd_cwnd(tp) >=3D hystart_low_window)
> from before calling bictcp_hystart_reset to after it.

Please change "The proposed fix" to "This fix", since if/when this is
merged, the commit will live on forever in git history and, for most
folks who read this, it will be an actual or accepted fix rather than
just a "proposed" fix.

> Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> Cc: David Eyers <david.eyers@otago.ac.nz>
> Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
> ---
>  Makefile             | 2 +-
>  net/ipv4/tcp_cubic.c | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7904d5d88088..e20a62ad397f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@
>  VERSION =3D 6
>  PATCHLEVEL =3D 13
>  SUBLEVEL =3D 0
> -EXTRAVERSION =3D -rc6
> +EXTRAVERSION =3D -rc7
>  NAME =3D Baby Opossum Posse
>
>  # *DOCUMENTATION*

Please remove this accidental unrelated change from your patch.

thanks,
neal


> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178..76c23675ae50 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 dela=
y)
>         if (after(tp->snd_una, ca->end_seq))
>                 bictcp_hystart_reset(sk);
>
> +       /* hystart triggers when cwnd is larger than some threshold */
> +       if (tcp_snd_cwnd(tp) < hystart_low_window)
> +               return;
> +
>         if (hystart_detect & HYSTART_ACK_TRAIN) {
>                 u32 now =3D bictcp_clock_us(sk);
>
> @@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *s=
k, const struct ack_sample
>         if (ca->delay_min =3D=3D 0 || ca->delay_min > delay)
>                 ca->delay_min =3D delay;
>
> -       /* hystart triggers when cwnd is larger than some threshold */
> -       if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> -           tcp_snd_cwnd(tp) >=3D hystart_low_window)
> +       if (!ca->found && tcp_in_slow_start(tp) && hystart)
>                 hystart_update(sk, delay);
>  }
>
> --
> 2.45.2
>

