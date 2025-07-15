Return-Path: <netdev+bounces-207235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC17B06504
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607371AA7D75
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC627D77D;
	Tue, 15 Jul 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UR9Fp/LH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046826CE27
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599845; cv=none; b=uAwgaMF6cZoDM311ypf3x23aPvA2ifu69Gc/rgdf+rTpHTwgw2dIq+UnRcBzjgDdSKvyBMaY7yRsnA1JQPLG2XbIRInwWsrtSNTI6ALxx5WWxFvRgpNcacOEN73G6KHFvknL1VuUO07GhA1mPsvgFCtt/UTDn92+NJFGE4ZvDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599845; c=relaxed/simple;
	bh=VUZDo0XypPHTrQkc0ob9/4EpHdmrecj1jwFdroYUaCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gj4i7LzVh0Gaoys8TFTY7xTLCXFP0upRpybSnyUbZcJU+VnMH54yuzDYZlLL5S6mJa3vnaBzM0vgC+f5RChif4uDUFP1BJRHncQLZT4TfdvhAMRUJBhcHU7v8NM4qj4mc27hKE1clHSJ/iROlq2zzcwHMSpOREYE89GodbejS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UR9Fp/LH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3139027b825so4489523a91.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752599843; x=1753204643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBzJE6YTkZ03D0TDxsw4pCwiNvK6jQyXb6N1iVx/Fl8=;
        b=UR9Fp/LH9Woit8AxdKdTlUC8UfJ5fHTwBD8k25Ki1bVFIvdESFXAnafSlZ712VlcYe
         7ikypMpOFvBXdvNqjlJnanlZas4LiQ1LN1sB+cespkv9rUrsTjoEoL9YOrsvYUMaVSyB
         rCbKFKlzP4/a6M+cjivTO2tg76OW9+ch2JxNspaJLBiObnO43KOi18fooI/o+rXoSZcq
         6Ocd2AvS5s1fwkcWk3UgTFCc5kM89J/KMQ55BsvA6UdmCeLlhDYcKQ+l2fuXAnWLUjQh
         +uD2hsvTpPCpzoKFt9f8DFfd1AP9oz0zqzm5g4LmIGu+NbkBfmcl3m2ZlOlAdYmcLZJQ
         l/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599843; x=1753204643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBzJE6YTkZ03D0TDxsw4pCwiNvK6jQyXb6N1iVx/Fl8=;
        b=WGSMbtn1WwWCwfGjQRhOxfNgspRBXDTIDdPgFkQw1TFQ9UbgIZxMO6HiKYeVKA14Yd
         MD/KPek0FsyuCWtNx0Kprwu4epO8euNcTcKcwb13MRaUH1I+QsZAVwJ+WrVWn/ihDE2o
         YeS4965qtchD6oPlOxOLm7tOb7sZ+/3bcyPXeW4trLD+z0blh44wC+xe0AzBpUCp/UqM
         j7ldVfeGxJo2tsuoUc0oKDewIhycSkts9QhQ+I/kXSoXBHvOSxcYpyBhgeZiE4fYHZyn
         tuhOEh3jp8ODCTIhjmNQGOmBTIsz5hJNQaI0V+AVvQKOgF1eOzA20mNBeAkRGqSrZ6H3
         Zl1w==
X-Forwarded-Encrypted: i=1; AJvYcCXEq2pXSUSqcjI5z6YoPcgJE6GLgKDKgVRSnlr9gTnKoKoABCflT6yJoQsVX2C1hck14Qbk1EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HySzo/PjOmerbxnFnIt5m+5gYKcwUpTQLw4aoPwckn4Iw5k1
	yzMHxvGwNZQXr3X9Tzexd6cvwZlat/V2GVL8mxl+ilCou+xRcenly4WWBqxCLbZhHtxUt5Xd16I
	myjur74llLRK6x1hgracqdqLjqgCZaLA9YSWbpm2s
X-Gm-Gg: ASbGncvGlf4ATRh54mGFBPNBD/fL7mEedR7grVw5ZnNv4h4irH7F2EZMpNAZ9KkKJ1R
	zH2RkIFn3lEez/xhUxgbCenUAr4TM4unFkgQ0tDkYGaZf5OMeFJHDnGg7eU3R4QBJ6SKBGZkSiV
	X5QiY8BoS0l/x2OVVumSQJBgY2MxU6xaN7XqYszv7f6XGRfrnIdys2gAZbfxDEKsfqxoHLT/seg
	yb6Eb3zeu/ahpETipAqLqr4QZ7PoH1jDNrwsQ==
X-Google-Smtp-Source: AGHT+IGS8Ve0NO4yhzFG58PVCTwdeB58lMcBo/7XS0S6ewWfzz9MR/+K/WG+zCR7MSrZ7bk3WMQHdvkbVWJOzYyeylQ=
X-Received: by 2002:a17:90b:3a08:b0:313:283e:e881 with SMTP id
 98e67ed59e1d1-31c4ca84a5fmr30431933a91.11.1752599842821; Tue, 15 Jul 2025
 10:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-3-daniel.sedlak@cdn77.com> <CAAVpQUAsZsEKQ65Kuh7wmcf6Yqq8m4im7dYFvVd1RL4QHxMN8g@mail.gmail.com>
 <8a7cea99-0ab5-4dba-bc89-62d4819531eb@cdn77.com>
In-Reply-To: <8a7cea99-0ab5-4dba-bc89-62d4819531eb@cdn77.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 10:17:11 -0700
X-Gm-Features: Ac12FXx9tRWpu9itogCzIOsSORL988MXK7dQ7rkzsNG49_Rp-vtFHy2swBsO4X0
Message-ID: <CAAVpQUDj23KHKpMFA4J7gV=H_BnvG4z0aVxf6-B04KsYtBL=1w@mail.gmail.com>
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

On Tue, Jul 15, 2025 at 12:01=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77=
.com> wrote:
>
> Hi Kuniyuki,
>
> On 7/14/25 8:02 PM, Kuniyuki Iwashima wrote:
> >> +TRACE_EVENT(memcg_socket_under_pressure,
> >> +
> >> +       TP_PROTO(const struct mem_cgroup *memcg, unsigned long scanned=
,
> >> +               unsigned long reclaimed),
> >> +
> >> +       TP_ARGS(memcg, scanned, reclaimed),
> >> +
> >> +       TP_STRUCT__entry(
> >> +               __field(u64, id)
> >> +               __field(unsigned long, scanned)
> >> +               __field(unsigned long, reclaimed)
> >> +       ),
> >> +
> >> +       TP_fast_assign(
> >> +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> >> +               __entry->scanned =3D scanned;
> >> +               __entry->reclaimed =3D reclaimed;
> >> +       ),
> >> +
> >> +       TP_printk("memcg_id=3D%llu scanned=3D%lu reclaimed=3D%lu",
> >> +               __entry->id,
> >
> > Maybe a noob question: How can we translate the memcg ID
> > to the /sys/fs/cgroup/... path ?
>
> IMO this should be really named `cgroup_id` instead of `memcg_id`, but
> we kept the latter to keep consistency with the rest of the file.
>
> To find cgroup path you can use:
> - find /sys/fs/cgroup/ -inum `memcg_id`, and it will print "path" to the
> affected cgroup.
> - or you can use bpftrace tracepoint hooks and there is a helper
> function [1].

Thanks, this is good to know and worth in the commit message.

>
> Or we can put the cgroup_path to the tracepoint instead of that ID, but
> I feel it can be too much overhead, the paths can be pretty long.

Agree, the ID is good enough given we can find the cgroup by oneliner.

>
> Link: https://bpftrace.org/docs/latest#functions-cgroup_path [1]
> > It would be nice to place this patch first and the description of
> > patch 2 has how to use the new stat with this tracepoint.
>
> Sure, can do that. However, I am unsure how a good idea is to
> cross-reference commits, since each may go through a different tree
> because each commit is for a different subsystem. They would have to go
> through one tree, right?

Right.  Probably you can just assume both patches will be merged
and post the tracepoint patch to mm ML first and then add its
lore.kernel.org link and howto in the stat patch and post it to netdev ML.


>
>
> >> +               __entry->scanned,
> >> +               __entry->reclaimed)
> >> +);
> >> +
> >>   #endif /* _TRACE_MEMCG_H */
> >>
> >>   /* This part must be outside protection */
> >> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> >> index bd5183dfd879..aa9583066731 100644
> >> --- a/mm/vmpressure.c
> >> +++ b/mm/vmpressure.c
> >> @@ -21,6 +21,8 @@
> >>   #include <linux/printk.h>
> >>   #include <linux/vmpressure.h>
> >>
> >> +#include <trace/events/memcg.h>
> >> +
> >>   /*
> >>    * The window size (vmpressure_win) is the number of scanned pages b=
efore
> >>    * we try to analyze scanned/reclaimed ratio. So the window is used =
as a
> >> @@ -317,6 +319,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memc=
g, bool tree,
> >>                           * pressure events can occur.
> >>                           */
> >>                          WRITE_ONCE(memcg->socket_pressure, jiffies + =
HZ);
> >> +                       trace_memcg_socket_under_pressure(memcg, scann=
ed, reclaimed);
> >
> > This is triggered only when we enter the memory pressure state
> > and not when we leave the state, right ?  Is it possible to issue
> > such an event ?
>
> AFAIK, the currently used API in the vmpressure function does not have
> anything like enter or leave the socket memory pressure state. It only
> periodically re-arms the socket pressure for a specific duration. So the
> current tracepoint is called when the socket pressure is re-armed.
>
> I am not sure how feasible it is to rewrite it so we have enter and
> leave logic. I am not that familiar with those code paths.

Unlike tcp mem pressure, the memcg pressure only persists for one
second, so it won't make sense to add the "leave" event, and I guess
the assumption would be that socket_pressure will keep updated under
memory pressure.

