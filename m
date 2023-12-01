Return-Path: <netdev+bounces-52852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E364880069A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C8E281390
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07601CAAB;
	Fri,  1 Dec 2023 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4K0dUSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9434194
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 01:10:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c52baaa59so5017a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 01:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701421817; x=1702026617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw0R1IIry/oGs15Umww96Xqt0mM/p6UWTCuyWlkeb9Y=;
        b=q4K0dUSh3w8QQibbWbfK98RVLkHIWDUm0ekqC8AWVUP6BXk4zwUOvZWVeCS61xMTXr
         HWfBEE6Oi/mWaZSEDT/MGMWxwtX3XPtG1eaQbikcboQwqbItWFT+N/jjoXtQzd69XNhC
         lCx9enLGLD/UxJbZaPJw6VAwFVSYCHGSPlJyhjjlZc/7tcf/AR1tN379JHr/TGEjJdJm
         Qf5FwYc+KzQeAYPkPjh6e02rEM8h9keW7pdEBNOwzBYhn2zQkjOS2fNIzGA+PmJp9mwP
         nOquSwZp3mm4GiuDHN00G2qiR0T/teBx/8aUN+GzOkTHjlcScN+Ef4cbQbxXqGM5UvMN
         HiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421817; x=1702026617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0R1IIry/oGs15Umww96Xqt0mM/p6UWTCuyWlkeb9Y=;
        b=s6w/3PUa4Al1IRChUN8Wh+RSR4VwDlKFHVkyRVLTSW4Wvpp1Lm51nNsFxoMmBKCsD1
         mbhDDzEfQAdyI68sSoVsqanv219XnUoUC1LfkZrotFLlw0QWxpZMBuN72fustjxex+/F
         rOQtTbZFOLiXl3m5wvQwCFw9QuphFcv5v1M20DOgPFLJvye5rVt2+LRA1VMeqZ7T9iW0
         dtFEvy4oVuc0uFOynI3P1hNgmwOFQ7FYyZewGwCn3RAj6wqFFL/JV3FG4yvTUfgHYtEZ
         xqvnhCA3UklgugZTZtks8CtH2tgw+qaMd11nbebWWrZ2xXjSPy8h53M5FvUwUfX3bT15
         26xg==
X-Gm-Message-State: AOJu0YwSaLl8TnxSzV7/fYTRgBeNi70Jnb5AVqhPVbeDWAxOff5iNg3u
	RdwZRS/tbFiS5rAJ7EFJFx6lIUXXSi/zJ0CCLVCQDQ==
X-Google-Smtp-Source: AGHT+IExbRrWsp/ALGMSgBAjAOP8RAHd/kQdgaIgWgrQColA+WI75KYK5BOYWUTq2i3Pbl9xQdJ0dUtK+Dp8pi1e3BU=
X-Received: by 2002:a50:d49c:0:b0:543:fb17:1a8 with SMTP id
 s28-20020a50d49c000000b00543fb1701a8mr47255edi.3.1701421817064; Fri, 01 Dec
 2023 01:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
In-Reply-To: <20231201083926.1817394-1-judyhsiao@chromium.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 10:10:03 +0100
Message-ID: <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Judy Hsiao <judyhsiao@chromium.org>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org> =
wrote:
>
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=3D1000 which expects tasks to be able to schedule in
> with ~1ms latency.

This will not work in general, because this code runs with BH blocked.

jiffies will stay untouched for many more ms on systems with only one CPU.

I would rather not rely on jiffies here but ktime_get_ns() [1]

Also if we break the loop based on time, we might be unable to purge
the last elements in gc_list.
We might need to use a second list to make sure to cycle over all
elements eventually.


[1]
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23ef=
09bb4b0db53b4
100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
        int max_clean =3D atomic_read(&tbl->gc_entries) -
                        READ_ONCE(tbl->gc_thresh2);
+       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
        unsigned long tref =3D jiffies - 5 * HZ;
        struct neighbour *n, *tmp;
        int shrunk =3D 0;
+       int loop =3D 0;

        NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);

@@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
                        if (shrunk >=3D max_clean)
                                break;
                }
+               if (++loop =3D=3D 16) {
+                       if (ktime_get_ns() > tmax)
+                               goto unlock;
+                       loop =3D 0;
+               }
        }

        WRITE_ONCE(tbl->last_flush, jiffies);

+unlock:
        write_unlock_bh(&tbl->lock);

        return shrunk;

