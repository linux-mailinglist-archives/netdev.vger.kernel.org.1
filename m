Return-Path: <netdev+bounces-166243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C73A35248
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 00:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED97B7A28F3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E31C84C1;
	Thu, 13 Feb 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glKGR2EU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E62753F0
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490193; cv=none; b=et9ATRgOOxPQw9HniIEwGSbIUnTIBSV1h1G6X+nY3WszLEyTOPlQ1EsTbr8cGtmSrg6bh6zEjSIUgkoWm0u2rTe40GnuH2iTlJzbLohsAVr1upZVM7lypupsHkzcLRJGhzZn5w8mUOSfYSXtEcytu3EBCms8J5ZFRShD6goHaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490193; c=relaxed/simple;
	bh=vp8maQYM2NETy6d6HTRzgvMFwPBGc9crI8DYbZ/TEx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQYGG4ixMTgZ49KNCZa29tARpPhaGAgDQFndB9ehkcfRnA0YY6PhUUXi9IM1bZWKpiMrIAFk6HQ01V4fmJxj14wHuAhAH1b9wmJTxnG7rGMEr4LnAzuDNOTfe91W3kTJxv1nXyEDELZQji09/uq8DAzBtzFlPoH1Lj6XW0m4hO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glKGR2EU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8553d7576daso44872139f.2
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739490190; x=1740094990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFeAELSTpJYJIDTrFfLsGAV6f5q4WkIpTckUd4qYPso=;
        b=glKGR2EUTMqVYCq3BqTZDiqvu1t4dEMWt3YC1ogjFC+MaSSbWklHbmbTLN0Kk7n+LR
         4THgUD6QF4vEkv146Pp3aHCHJWvPjB0l+kvsJ1zBDQD+rO119E9w4aFE9fJNf8auSLGV
         azS191c/DLh83YvGT5m37w22nnvK+RpaDanK5xMwXGeNl8QMNy3395saMES8y/PEsYbo
         oVFCH7pF+r2PDHFqURwbhhCOIYgDQ1o3sQGYipy+dokuT8lBY6oUliEE5t1aDmmHnn0Y
         vBH/7dh/yFdUCRMGmPo1mgwYT9SstO3I0cO/9mny+nQADVDkqdka4vV7fGyABF/xqHlQ
         GBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739490190; x=1740094990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFeAELSTpJYJIDTrFfLsGAV6f5q4WkIpTckUd4qYPso=;
        b=LA75JQ8xdh/j/e2HAXKiFLIeG1VtykgKBSNiOvgIZUUySSiAUNIqZ8qT43P1jN3ia5
         XzTDi1RFWKPJc+ZLbi2EET61T0N/5hJ4ci8sK0huv6XN1XA7/wTtCK4Qnyl7yNYiXFc0
         Fw0REGewnocLAWmi5y0zbwZ16sJlGDdSlzEihf/1XIH8hx73cXxX8+gszfLO7qSMlsRp
         WFKH9kpzQTQ6epvui2jWIZIw2RyHDBFl+hbDSuxFJzKZpU/YY+yzFrm4Jm31zSHWCH5x
         I9K5o59Zm6t2U1o7YGylY05V8z9xLBbTrI/AFntCbZY6bgpJAqM6SdO+hPiN7sCnL3Il
         t47Q==
X-Forwarded-Encrypted: i=1; AJvYcCX48hhfRRrWYGnEYIorkV2Y7pAuRF3p6gpLZj1VCPua7Jv5nFEy80b+2YgmkxbtjDYw7qaed8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYBNLShH3rjbT1uKeeVeBEF3MGzxdqVFoPAkiwQ1ZhTlGmIda
	RbCtAfyuS7cuUv/M0oVIblDMlPn8Lx3ZO78QWocJmp2wtyUizc0TuZSvApylKEjmYRQMUIJkfcw
	cB6hmb4VjE+OcpSfcWfZ0ql/MpvE=
X-Gm-Gg: ASbGnctgeYyWf4mCoKsCCkxgbLPKRSHqGjifj62RM9VcVozCmOsD+fgLvAWN+YgqtX/
	8M9id2txCMKIHM12vARsTYir/7dG2VNY+7Di4pzjcPOGADeI7fwF3/E3btlwXa5rbqJeh+qc=
X-Google-Smtp-Source: AGHT+IEM7EzWs6YT42s3AKN/FsDxk0f2GaQtvlhqwKvmsqBc1OHAClAjJ0j4DbrClq5hpR1AyxPs02VmYORDMW670rQ=
X-Received: by 2002:a92:c569:0:b0:3cf:b9b8:5052 with SMTP id
 e9e14a558f8ab-3d18c21e82cmr48868285ab.3.1739490190545; Thu, 13 Feb 2025
 15:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213052150.18392-1-kerneljasonxing@gmail.com>
 <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com> <CAL+tcoC6r=ow4nfjDvv6tDEKgPVOf-c3aHD56_AXmqUrQMyCMg@mail.gmail.com>
 <CAHS8izO0CdzNti7L3ktg4ynkJSptO96VtrzvtUEkzUiR7h38dg@mail.gmail.com>
In-Reply-To: <CAHS8izO0CdzNti7L3ktg4ynkJSptO96VtrzvtUEkzUiR7h38dg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Feb 2025 07:42:34 +0800
X-Gm-Features: AWEUYZkmICFkEmEYImHxLh4sUJLDpNFlre_CLFRpR21OSifU6XWgYYl5PcONNEM
Message-ID: <CAL+tcoAmYayRmZ=GFpzwczudT4pTwRpH+AMv4TkwSP39q3snDQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	ilias.apalodimas@linaro.org, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 4:14=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Thu, Feb 13, 2025 at 2:49=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 4:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 2/13/25 6:21 AM, Jason Xing wrote:
> > > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > > index 1c6fec08bc43..e1f89a19a6b6 100644
> > > > --- a/net/core/page_pool.c
> > > > +++ b/net/core/page_pool.c
> > > > @@ -1112,13 +1112,12 @@ static void page_pool_release_retry(struct =
work_struct *wq)
> > > >       int inflight;
> > > >
> > > >       inflight =3D page_pool_release(pool);
> > > > -     if (!inflight)
> > > > -             return;
> > > >
> > > >       /* Periodic warning for page pools the user can't see */
> > > >       netdev =3D READ_ONCE(pool->slow.netdev);
> > >
> > > This causes UaF, as catched by the CI:
> > >
> > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/990441/34-udpg=
ro-bench-sh/stderr
> > >
> > > at this point 'inflight' could be 0 and 'pool' already freed.
> >
> > Oh, right, thanks for catching that.
> >
> > I'm going to use the previous approach (one-liner with a few comments):
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 1c6fec08bc43..209b5028abd7 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct
> > work_struct *wq)
> >         int inflight;
> >
> >         inflight =3D page_pool_release(pool);
> > -       if (!inflight)
> > +       /* In rare cases, a driver bug may cause inflight to go negativ=
e.
> > +        * Don't reschedule release if inflight is 0 or negative.
> > +        * - If 0, the page_pool has been destroyed
> > +        * - if negative, we will never recover
> > +        *   in both cases no reschedule is necessary.
> > +        */
> > +       if (inflight <=3D 0)
> >                 return;
> >
>
> I think it could still be good to have us warn once so that this bug
> is not silent.

Allow me to double-check what you meant here. Applying the above
patch, we do at least see the warning once in
page_pool_release_retry()->page_pool_release()->page_pool_inflight()->WARN(=
)
before stopping the reschedule.

Do you expect to see another warning, namely, pr_warn() in
page_pool_release_retry()? If so, I assume you expect to only print
out the pool->user.id?

>
> We can return early if page_pool_release(pool) =3D=3D 0, and then only
> schedule_delayed_work() after the warning if inflight is positive.

Based on the above analysis, can we adjust in this way:
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1c6fec08bc43..e1831cc23d9c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -625,8 +625,8 @@ s32 page_pool_inflight(const struct page_pool
*pool, bool strict)

        if (strict) {
                trace_page_pool_release(pool, inflight, hold_cnt, release_c=
nt);
-               WARN(inflight < 0, "Negative(%d) inflight packet-pages",
-                    inflight);
+               WARN(inflight < 0, "Pool id(%u): negative(%d) inflight
packet-pages",
+                    pool->user.id, inflight);
        } else {
                inflight =3D max(0, inflight);
        }
@@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct
work_struct *wq)
        int inflight;

        inflight =3D page_pool_release(pool);
-       if (!inflight)
+       /* In rare cases, a driver bug may cause inflight to go negative.
+        * Don't reschedule release if inflight is 0 or negative.
+        * - If 0, the page_pool has been destroyed
+        * - if negative, we will never recover
+        *   in both cases no reschedule is necessary.
+        */
+       if (inflight <=3D 0)
                return;

Thanks,
Jason

