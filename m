Return-Path: <netdev+bounces-89102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E98A9749
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CD91F2367C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14015B98C;
	Thu, 18 Apr 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GYtUUt75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE215CD50
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435823; cv=none; b=jkIxhInT9cTqrLqdDiEFtINvZx+vbZrCCK7GmgVNxGFWs8l3zv/5su3Fo84RLGq377NOh2jZE7QFDKZOlYAlLy3TAyxTlerJmhiz83gWsPfhxTd5z73npYnbgIrwxrXNM6TC7nj2dl23vpHw8kjMpb1a/jlehvOv0wxd7hGUNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435823; c=relaxed/simple;
	bh=1RAPZWug0mFeYY+MRomiDGhKalyDJPIwrX5AYv30e3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HijRB2q6aNrnyfg6ZCYQ2T6Hl5m/uKhI5Ry8b6eA+gCBfQhts305uQipXfQ6+KJzCPJV6o0RujvLreVLzVYM1olpgKAbZZM04fpbKx9keC1Xt/q0el+zEoav4uAIYjpVF+QhD6xaNuoN9Gn9y7Pe50dyY+DNLx2s+Q2xjn/GPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GYtUUt75; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-617f8a59a24so5753267b3.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713435819; x=1714040619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrbWhLqLJHpOUWVNzATaTjg9kOc7W7R4zAHxyGzA8QY=;
        b=GYtUUt75zAEYEdQYAvie2Qxhf/LDkFMRXpP7nJXRgKhA62Ksce6q16vDWOGaxHHX8q
         a1AJjjaSYArg8Vrlyq6nAi/JFtnDCrWxX8ZxmL+V3HeSmZW52NUNuJd/9J7YVaLQGwuY
         YXl9qh9PfTgsmqA+5W2jc6JtBdIVVtZqB7EKtbq7ST4GHEUa5XaVW1Ek+/zikGqcCtlI
         jmu/TPDr0AsglpHmGVIo/qI2CpsSre/gLH84gkQShdCQJOpZKgqNcvampQakX6xADXvN
         NA49X6vjCmKBi3FsLRYBNbGXch94O0GDGHPKzIYTLNL160CdtYE+lns6v4241yBdue1z
         3mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713435819; x=1714040619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrbWhLqLJHpOUWVNzATaTjg9kOc7W7R4zAHxyGzA8QY=;
        b=IJu6QnnbHH533tmgaVjIt1MOxDr2IzCfdy4ebVw+YevlBEFzfyJ8LsWbB7wR8+s/So
         SDxHpwnE63XBkCykgQhteJS036Z4maX2byXySVtW2fGOWxQ/ivsIVsvvsdMVnfnVfBV+
         Cxd81qFEBI+kNXTtAYgThzH7PkOV4cm9ON5YYnznDXVr4xqrFx7yNlRBs1bVhRycw7vp
         utzkWt0FdwN0/QCe+JTwrpV0W6m1cO3sFBY19jWCtNf40uCEcvsb8F8YCjBLnisybcvQ
         hybTa9kDoRbIFOV+Rvfz1hc745ireZpTqNq77DMnmm6gsTFAHNrWclZVXhdzPIwwMGlJ
         tWEw==
X-Forwarded-Encrypted: i=1; AJvYcCUPq8mr+Lt5ysrk4nEv2s3xerm8vtbvhlQ2UPO0JSxSyJ+jpHUIHY91ZZ3etqQWOsy976/RzOy+13LKc8DzCrXZTUhwAFo8
X-Gm-Message-State: AOJu0YwBfwTc8ppR3t+KG3I1KNlfta1bRWotdjxoTlFtN9I4OABFPG9N
	JtJjSFg2VUz54oYe9ylA+vQzD4XcMuGTB4AFczR4mjhGMraXq+9woiNnkYW/8/PPpAHJQRPx67B
	Atxp09OgoxeG1/ClGj2ya5scTpDJdDoow8mjm
X-Google-Smtp-Source: AGHT+IFX2zMvZ/+TvTsyPnlDOugRpGxkpS7kV3qMl7k8derxihBSd0gy2vC0iRIc1Hax4XzkMis99SADhFLG0hCiVKc=
X-Received: by 2002:a05:690c:3745:b0:60a:17a2:5627 with SMTP id
 fw5-20020a05690c374500b0060a17a25627mr1972276ywb.50.1713435819428; Thu, 18
 Apr 2024 03:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 18 Apr 2024 06:23:27 -0400
Message-ID: <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/14] net_sched: first series for RTNL-less
 qdisc dumps
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Medium term goal is to implement "tc qdisc show" without needing
> to acquire RTNL.
>
> This first series makes the requested changes in 14 qdisc.
>
> Notes :
>
>  - RTNL is still held in "tc qdisc show", more changes are needed.
>
>  - Qdisc returning many attributes might want/need to provide
>    a consistent set of attributes. If that is the case, their
>    dump() method could acquire the qdisc spinlock, to pair the
>    spinlock acquision in their change() method.
>

For the series:
Reviewed-by: Jamal Hadi Salim<jhs@mojatatu.com>

Not a show-stopper, we'll run the tdc tests after (and use this as an
opportunity to add more tests if needed).
For your next series we'll try to do that after you post.

cheers,
jamal
> V2: Addressed Simon feedback (Thanks a lot Simon)
>
> Eric Dumazet (14):
>   net_sched: sch_fq: implement lockless fq_dump()
>   net_sched: cake: implement lockless cake_dump()
>   net_sched: sch_cbs: implement lockless cbs_dump()
>   net_sched: sch_choke: implement lockless choke_dump()
>   net_sched: sch_codel: implement lockless codel_dump()
>   net_sched: sch_tfs: implement lockless etf_dump()
>   net_sched: sch_ets: implement lockless ets_dump()
>   net_sched: sch_fifo: implement lockless __fifo_dump()
>   net_sched: sch_fq_codel: implement lockless fq_codel_dump()
>   net_sched: sch_fq_pie: implement lockless fq_pie_dump()
>   net_sched: sch_hfsc: implement lockless accesses to q->defcls
>   net_sched: sch_hhf: implement lockless hhf_dump()
>   net_sched: sch_pie: implement lockless pie_dump()
>   net_sched: sch_skbprio: implement lockless skbprio_dump()
>
>  include/net/red.h        |  12 ++---
>  net/sched/sch_cake.c     | 110 ++++++++++++++++++++++-----------------
>  net/sched/sch_cbs.c      |  20 +++----
>  net/sched/sch_choke.c    |  21 ++++----
>  net/sched/sch_codel.c    |  29 +++++++----
>  net/sched/sch_etf.c      |  10 ++--
>  net/sched/sch_ets.c      |  25 +++++----
>  net/sched/sch_fifo.c     |  13 ++---
>  net/sched/sch_fq.c       | 108 ++++++++++++++++++++++++--------------
>  net/sched/sch_fq_codel.c |  57 ++++++++++++--------
>  net/sched/sch_fq_pie.c   |  61 ++++++++++++----------
>  net/sched/sch_hfsc.c     |   9 ++--
>  net/sched/sch_hhf.c      |  35 ++++++++-----
>  net/sched/sch_pie.c      |  39 +++++++-------
>  net/sched/sch_skbprio.c  |   8 +--
>  15 files changed, 323 insertions(+), 234 deletions(-)
>
> --
> 2.44.0.683.g7961c838ac-goog
>

