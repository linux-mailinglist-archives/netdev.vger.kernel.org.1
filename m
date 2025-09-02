Return-Path: <netdev+bounces-219112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6C9B3FF0A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2991B2655F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF12FD1A4;
	Tue,  2 Sep 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="T0xllWaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46372FC89A
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814271; cv=none; b=G2DxFPZHeJKGi0HTPSUVC5krX4LamMTbiwSM4eynJzeIpW61rPzDumJVGo9SOW3jL+ovltDJadDch8bIWUWmusC+mnyFM3XIrzM5vLtmUyPkgfjtenkNbCbd0nPBKFC3VymA9/JtDv5lJ5wwzyrBwUDANuun392x1wFcuDRbKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814271; c=relaxed/simple;
	bh=ISz2R8nIL/XKaHCPVYKnUQi4C4U/XCPWTExqn54SX3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA1OBXxclWYTQhmxg+2TuPgYCiZP2fAYABoLE1WzBZA/x6HWTlIm65uYMSsAQQa4sy78AEbTtxuwA28PUzjoPAJlsrUQtnHjiqlqys77w0XMh/b7eszDAIUimtLd/TvQFgizHSZJcD6DzCJG1ZVEngKUBk9lbJAp5miHFRiRtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=T0xllWaf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b76008c6so1358329a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1756814269; x=1757419069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZZmLX3tN1DDyOfkyiTt04sxH4+Jvzt0ZNUfRIiYlA4=;
        b=T0xllWafvRic+SLdwIliZ2MOmYYixF2Jebk5lM0Y0T/ymylABbo9CjjYP7qrSHk66n
         elsSV52kpGstArDrIzXF3Oi8EhgEKNz0LeXmEQ8ViV878oRmiCD7ulSykNYdChtNBzNm
         6FB+8YmAPMZwyM6X0Pqveim5iDwx8CbBnWoNB3A2nsBf1CQwz6MHwjNJEsCYtBlb7ulO
         +kjpli35XFysaucz5IPYiUFb7mVCDV0uHSXUND4ASggueUmhmErI+GC7ChFiXKd/jAj3
         N9LUv6OZuH9OIq2BA2A7QDCah9RwWGYNk5rDBuoiS2JcbYo1sD7jGaqNgGnqo8qWEaQw
         wIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814269; x=1757419069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZZmLX3tN1DDyOfkyiTt04sxH4+Jvzt0ZNUfRIiYlA4=;
        b=Ad2oWA0Uv3Fm2Z2HlTj9GsJhuFuj1eX2MKVg5h8ZIUaY2L9KwdMPgDFyJ8U0Tk7Mxu
         PsQCNtjVmSXPFB/Ii/0kPFTmswtpuzEJAI1+n0jn4rc29hKr9azcNrxsg3IrI6sdDfKu
         TR91m3mOhzD52RgyMUdgNZmS9DbgorWrL3DLI6q/5O4OJsgxNEf8uVD8TCE7phES9JPK
         8BuYSIKVGxSTot5mAIF66Q0kZivFd7nRIw5FMCX+/mTynw6udUX7lNfvt4pNeIRhCFUO
         bo3xYHXYMlucNvKP3GCUunMGP/GXD2bS7HiWimpicW86Sz30UGOPcTNwFd+OMy/flUVj
         SzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzFpVOrGNWYW9Q90RUt4A73+U4T1YyuFbnuiaBoxBPGY9HUgj8CKSkuq+2EELQVe3x3QEhIK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3Dis9qTqVNPd1Dnr2T2t9Hb61sx4v1y73nZMVI3WLtRT6o+e
	p2WdrZqkum/XSq4mn0CD3t7bOvXCxcMXoyA1qOeMcmcw7sGcIkHyogn1/puJy+eaHfGv7Am5Btx
	hUhJZP2kNQX3+kdmsaSdS+tUrXN0EfMK6Xbrt+1KA
X-Gm-Gg: ASbGncu6wV1/ee0461ecZtivGJQp+7dHowk2w068c1tYcKdh1poRdjs10mYRDZfs5so
	oucmzHcoNZlpdhTEFQUxA36Zb9x5SBpVGHfWPgWELk0/8l4fYF/k9qXnVA/L+ogWM29HVorVqNk
	KaCaRmIqGk2GOHQdh1Jxb2YV/vAKCanNrp/fSIor/BNwiT/G+3HCZw2+AVZo9y59JyY6u74gjm6
	OucEIM2UXx2IK7+WQ==
X-Google-Smtp-Source: AGHT+IEEMtTLIaK760YpNra5+wTJN1dQXo3Tso8+FKqvqYQ3nHm+9ibF9FE+YidocZj3hGec+kpqRk4uBsTTRaWNmX0=
X-Received: by 2002:a17:90b:57cf:b0:329:887a:1e8b with SMTP id
 98e67ed59e1d1-329887a20e0mr10691348a91.27.1756814268912; Tue, 02 Sep 2025
 04:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901093141.2093176-1-edumazet@google.com>
In-Reply-To: <20250901093141.2093176-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Sep 2025 07:57:32 -0400
X-Gm-Features: Ac12FXyhz23f17t_Qh8Gbg0tIdbGJA8vdGpWQ2aFQqebroox-tWh_UENVU9vxWM
Message-ID: <CAM0EoM=KPSO6aA+iSZ+LdgAg34sEs9yPnJtKLKVT7jji5EQcsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: act: remove tcfa_qstats
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tcfa_qstats is currently only used to hold drops and overlimits counters.
>
> tcf_action_inc_drop_qstats() and tcf_action_inc_overlimit_qstats()
> currently acquire a->tcfa_lock to increment these counters.
>
> Switch to two atomic_t to get lock-free accounting.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  include/net/act_api.h | 14 ++++++--------
>  net/sched/act_api.c   | 12 ++++++++----
>  2 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 2894cfff2da3..91a24b5e0b93 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -33,7 +33,10 @@ struct tc_action {
>         struct tcf_t                    tcfa_tm;
>         struct gnet_stats_basic_sync    tcfa_bstats;
>         struct gnet_stats_basic_sync    tcfa_bstats_hw;
> -       struct gnet_stats_queue         tcfa_qstats;
> +
> +       atomic_t                        tcfa_drops;
> +       atomic_t                        tcfa_overlimits;
> +
>         struct net_rate_estimator __rcu *tcfa_rate_est;
>         spinlock_t                      tcfa_lock;
>         struct gnet_stats_basic_sync __percpu *cpu_bstats;
> @@ -53,7 +56,6 @@ struct tc_action {
>  #define tcf_action     common.tcfa_action
>  #define tcf_tm         common.tcfa_tm
>  #define tcf_bstats     common.tcfa_bstats
> -#define tcf_qstats     common.tcfa_qstats
>  #define tcf_rate_est   common.tcfa_rate_est
>  #define tcf_lock       common.tcfa_lock
>
> @@ -241,9 +243,7 @@ static inline void tcf_action_inc_drop_qstats(struct =
tc_action *a)
>                 qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
>                 return;
>         }
> -       spin_lock(&a->tcfa_lock);
> -       qstats_drop_inc(&a->tcfa_qstats);
> -       spin_unlock(&a->tcfa_lock);
> +       atomic_inc(&a->tcfa_drops);
>  }
>
>  static inline void tcf_action_inc_overlimit_qstats(struct tc_action *a)
> @@ -252,9 +252,7 @@ static inline void tcf_action_inc_overlimit_qstats(st=
ruct tc_action *a)
>                 qstats_overlimit_inc(this_cpu_ptr(a->cpu_qstats));
>                 return;
>         }
> -       spin_lock(&a->tcfa_lock);
> -       qstats_overlimit_inc(&a->tcfa_qstats);
> -       spin_unlock(&a->tcfa_lock);
> +       atomic_inc(&a->tcfa_overlimits);
>  }
>
>  void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets=
,
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 9e468e463467..ff6be5cfe2b0 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1585,7 +1585,7 @@ void tcf_action_update_stats(struct tc_action *a, u=
64 bytes, u64 packets,
>         }
>
>         _bstats_update(&a->tcfa_bstats, bytes, packets);
> -       a->tcfa_qstats.drops +=3D drops;
> +       atomic_add(drops, &a->tcfa_drops);
>         if (hw)
>                 _bstats_update(&a->tcfa_bstats_hw, bytes, packets);
>  }
> @@ -1594,8 +1594,9 @@ EXPORT_SYMBOL(tcf_action_update_stats);
>  int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
>                           int compat_mode)
>  {
> -       int err =3D 0;
> +       struct gnet_stats_queue qstats =3D {0};
>         struct gnet_dump d;
> +       int err =3D 0;
>
>         if (p =3D=3D NULL)
>                 goto errout;
> @@ -1619,14 +1620,17 @@ int tcf_action_copy_stats(struct sk_buff *skb, st=
ruct tc_action *p,
>         if (err < 0)
>                 goto errout;
>
> +       qstats.drops =3D atomic_read(&p->tcfa_drops);
> +       qstats.overlimits =3D atomic_read(&p->tcfa_overlimits);
> +
>         if (gnet_stats_copy_basic(&d, p->cpu_bstats,
>                                   &p->tcfa_bstats, false) < 0 ||
>             gnet_stats_copy_basic_hw(&d, p->cpu_bstats_hw,
>                                      &p->tcfa_bstats_hw, false) < 0 ||
>             gnet_stats_copy_rate_est(&d, &p->tcfa_rate_est) < 0 ||
>             gnet_stats_copy_queue(&d, p->cpu_qstats,
> -                                 &p->tcfa_qstats,
> -                                 p->tcfa_qstats.qlen) < 0)
> +                                 &qstats,
> +                                 qstats.qlen) < 0)
>                 goto errout;
>
>         if (gnet_stats_finish_copy(&d) < 0)
> --
> 2.51.0.318.gd7df087d1a-goog
>

