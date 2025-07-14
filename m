Return-Path: <netdev+bounces-206804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB86B04710
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02127A49F9
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174B26A1AE;
	Mon, 14 Jul 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLIjyCy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D325A645
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516181; cv=none; b=maUoUEknUBpq7kRg1sD/dYYL15WZcheiVI6klSyR8AL5sOZ8bdKcJm7czuXbuFVbRflPwLmLiJS2OeykmRITqzHUk/f5WmAW/+xp9l+4RQyEpziYZoQOhOIIdCLyVdWkZMDDRUxlmB0xshf7timIPHmrwStrVOSDMuJ410n0//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516181; c=relaxed/simple;
	bh=bD7rg46lG+a95esZQz8sRVTb5zo8aMwzO2OCspQPot8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS03naSdUxKX2EbvgZ74KsciOBI+Hp5s7xqNSmElJpNOp0ilStQqiTTv3AW7qBc5JOKG4zhUw2LrqVwEitlTj6OBDmSahcqr7zRh2BqDVQufR1QSYj/OOsgIXTqlDqufZR3XFgbAbFCpgHanAd5EyNqzYJ93Q+bc02k/qUTrLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLIjyCy3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23dc5bcf49eso56254535ad.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752516180; x=1753120980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6E+Nzc/K3p/4FxVNjQXCo2R2Lfp11YKUIbLXFvX0bo=;
        b=OLIjyCy3nbT9beUQVnr4z2ksa7e6i7qomyNxNOlNX7SoA/NuPFxOhs8O8IqIHz0Y5J
         OcBP/LUwJXJ/7v6OAkoo7bCU3VqRH6Wd3ke2inTARgHgcF5cisntakNPgpWftSFGLL8X
         gf58Kr3Lk25EFqf1Eo0c9X8t7Rf55hFQzXD4o8DHw5EqbvovrQVZ9yRV7JVZGI7BV8X+
         RLSFu6CVSpJUz+xFayFqP+EhQ5gq0x4OCYeoP9RyurHQZ5QcCCON0a0OtnjroHM5tfdr
         mA2/4CUPjoK98+rSNy8KZMtYa/oKuDyuDlLAoAG9DDZq14JxQuF/d8uEHOf6HsQC6Vy4
         PkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516180; x=1753120980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6E+Nzc/K3p/4FxVNjQXCo2R2Lfp11YKUIbLXFvX0bo=;
        b=ZSlS1LpgrT6185PwjLiGpI89SSvb3VEFISxQBdEJYvmY8qNQazzkes0/1JVCYOpinW
         mUlLDVv2sUhR3djmml/7dbCKQ2+C4S6OUj8shmMsCENokeTb9Tg7PCZUkDseF357LYYj
         QUY3VmOYkxquSiBtAbUxiyo2Up9K0csgmsoORArnQiPWvdyqArftSvUXAHY9SQ2OXEi3
         Cwy0IFPcyPttNGrVnxgh8veVeHV44dW4YmbHfpjyfGd8ll8tZmHLRD3FVAPDOrdQEcbK
         aG8bEw6jKQgB5dOi+phyS/HXbxCPSbOnP/ID61YHhMvmMMKyoEhTX1ZGq8MEg94gQdQZ
         kldw==
X-Forwarded-Encrypted: i=1; AJvYcCV6YO2URmezWhOvM/LNHNTViuOexauSWA/vJDa+FKxEVVu7EZjTDU76Y5SPC1d2yqo4nhvmAUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnp0Wq/hDqFGQcogSA/YObBOZVVkBx+cxVidVebRmsYaZXtWT
	KwxokF8rzzGI0lOnAtC+0mlp0sFM1QT1J3G6hmFgaQYgPu7O1DeAOi7+/yinahPWRNcfDrLNKqp
	vVRw/hhyCk8hz9XDnWQueI943OF4F81hMP2dgLXMG
X-Gm-Gg: ASbGncuVjTaW2erSS3LiTkiBnC0eletjmn1haiFrFkC8IU21ogZLqrsAwI+RKoWhssS
	EjVV31g9gMMm+u6t3bKu2145KMo9OCSvSCS2Rod2o3EX7aHjVEV50aL9thWuzOJs0EOu4OAPXv8
	lGc47PXVzgkOMDucRM3W1wJxJlUicQdgeaf0C+8rYLSqQOCppcrK8MaKyplpU0hLuZIEox2F8TW
	zjxW3e0JAqd74skb3Ydfe4uUNZtir+DNKIXTJ09zEic1gOY
X-Google-Smtp-Source: AGHT+IG7PqofdZIi6yyWYFtnJ1dgVAahvuF6PnKF2gEfcQ1LCBFisX0Vuf5x7Rorv4erCoSRhDGF4a/Rpp1v19w9Q10=
X-Received: by 2002:a17:903:2b0b:b0:23c:863d:2989 with SMTP id
 d9443c01a7336-23dede2cc82mr209125765ad.3.1752516179303; Mon, 14 Jul 2025
 11:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com> <20250714143613.42184-3-daniel.sedlak@cdn77.com>
In-Reply-To: <20250714143613.42184-3-daniel.sedlak@cdn77.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 11:02:48 -0700
X-Gm-Features: Ac12FXz9MdgoMJI07wN-4_mDJf6QjZu83kf2eiskVdklZE-t6ycrn9vI5oAn9u4
Message-ID: <CAAVpQUAsZsEKQ65Kuh7wmcf6Yqq8m4im7dYFvVd1RL4QHxMN8g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] mm/vmpressure: add tracepoint for socket
 pressure detection
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>, Daniel Sedlak <danie.sedlak@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:37=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77.=
com> wrote:
>
> From: Matyas Hurtik <matyas.hurtik@cdn77.com>
>
> When the vmpressure function marks all sockets within a particular
> cgroup as under pressure, it can silently reduce network throughput
> significantly. This socket pressure is not currently signaled in any way
> to the users, and it is difficult to detect which cgroup is under socket
> pressure.
>
> This patch adds a new tracepoint that is called when a cgroup is under
> socket pressure.
>
> Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Co-developed-by: Daniel Sedlak <danie.sedlak@cdn77.com>
> Signed-off-by: Daniel Sedlak <danie.sedlak@cdn77.com>
> ---
>  include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
>  mm/vmpressure.c              |  3 +++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> index dfe2f51019b4..19a51db73913 100644
> --- a/include/trace/events/memcg.h
> +++ b/include/trace/events/memcg.h
> @@ -100,6 +100,31 @@ TRACE_EVENT(memcg_flush_stats,
>                 __entry->force, __entry->needs_flush)
>  );
>
> +TRACE_EVENT(memcg_socket_under_pressure,
> +
> +       TP_PROTO(const struct mem_cgroup *memcg, unsigned long scanned,
> +               unsigned long reclaimed),
> +
> +       TP_ARGS(memcg, scanned, reclaimed),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, id)
> +               __field(unsigned long, scanned)
> +               __field(unsigned long, reclaimed)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> +               __entry->scanned =3D scanned;
> +               __entry->reclaimed =3D reclaimed;
> +       ),
> +
> +       TP_printk("memcg_id=3D%llu scanned=3D%lu reclaimed=3D%lu",
> +               __entry->id,

Maybe a noob question: How can we translate the memcg ID
to the /sys/fs/cgroup/... path ?

It would be nice to place this patch first and the description of
patch 2 has how to use the new stat with this tracepoint.


> +               __entry->scanned,
> +               __entry->reclaimed)
> +);
> +
>  #endif /* _TRACE_MEMCG_H */
>
>  /* This part must be outside protection */
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index bd5183dfd879..aa9583066731 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -21,6 +21,8 @@
>  #include <linux/printk.h>
>  #include <linux/vmpressure.h>
>
> +#include <trace/events/memcg.h>
> +
>  /*
>   * The window size (vmpressure_win) is the number of scanned pages befor=
e
>   * we try to analyze scanned/reclaimed ratio. So the window is used as a
> @@ -317,6 +319,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, =
bool tree,
>                          * pressure events can occur.
>                          */
>                         WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> +                       trace_memcg_socket_under_pressure(memcg, scanned,=
 reclaimed);

This is triggered only when we enter the memory pressure state
and not when we leave the state, right ?  Is it possible to issue
such an event ?


>                 }
>         }
>  }
> --
> 2.39.5
>

