Return-Path: <netdev+bounces-226551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303ECBA1DB1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 00:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B318881E1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E1322A3B;
	Thu, 25 Sep 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjsyX2k9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36F321F34
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840065; cv=none; b=T05Gsd0l4D/sweD/iwrwf1+5jw+Eimj+J2szAWwyFafaSgsK5nYbMzdp+MTv1ClNwPR9ZdIk8d5tL2AbVW720u9ktzrUwpcQrbsTv5tQX6PM6kkMljrC9mK291VA/TGnRB5ir+v6y+PZXZHxcLqbYju6qXusF4HY/+URhYduX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840065; c=relaxed/simple;
	bh=7tMZH6BL6w19NBpb9eF+n2B8nj1FBXXU5RvXUM3XZwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATvBVIbCaW+YmHEZoPlCLW4CYu7KwfFT7UQ3rOVxtz4j/8M0UR43NiXRoiDnWBF0IDA+Z6YB0f6Um2FAJDHC5l7rEFl2KPxEdtBSIfKEx/9tnu4X8b4m+sa5sI2hVkVqGQ7UGIyQ65e8KXKC+EYR4Jc+04s79DKNP/8FAa8T5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjsyX2k9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b523fb676efso1545477a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758840063; x=1759444863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiRfZeXVBII9n8+rM3U1QlqGk0PSxFWiOe+LlIXh4J0=;
        b=BjsyX2k9X0i1oDXpRq2/qPJBv8ZKQttdYhhRSAYdPAtWsQDDSCtR9HHpTWY+ToO9y8
         Gw7dfWU4bigV2ndpBgxtiSzwBDNR9qvf1mRJ8d4wZCU3jkduxgdg/ZrZKEbgcee4H1u2
         ceR//3g1hXPE6levVImk/JkqG74QKJxOad5UBcf8SPIjjN8g8zO11EKWKXhwZ6TqsNxS
         TEuYJAdt6gUyONxo6toWtonL2bz60GeOqeb2FfjmzpyQQu7r4u69l92cCZ5zLQPr6Oi9
         biQ+4awLNamFEkKAhOe54LUOAFa7TmSkpfhF8+uw8NlyGXDrhOSG069hN5LvyrAAcMkr
         d46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840063; x=1759444863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiRfZeXVBII9n8+rM3U1QlqGk0PSxFWiOe+LlIXh4J0=;
        b=qin9a1BD8/t7iQtOvun/FUl3YDVpE5YhOMuDbm2YKpj9OBuD8RgMwwUVKc3o1APuci
         5HbMGDTwJKulORqZkpN+V628wuS9sGnzFTgJkKK3oVCdg3TmPVZK8cTp9jsu19TQkcV9
         4kDz6znLYi73obCRDtkhwOTaGoMipkMfmYXNt1KdGu62dFOOaG+5eLOtHbGQWej04uu1
         JuLC9x616eIA780MloOWwdCb1pqHChC2rQrPV9tDX/RINiJMSSdJ79yx1VxdkXcy+YDY
         TBrsxwo4YPXuALvBdJ6NWGN6GYhMUCT42y0zOeUJIZnAH4LYV/ziS5BVu0qHrMpgMP7M
         icVg==
X-Forwarded-Encrypted: i=1; AJvYcCVg6IYg8PJuCtQwwKeIKfeDS8kY2rTFUagvd4alt/F0UhCROxI7Jr8CdAK6IY+YrmRDJT0ZJPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7DTD9tNj1TlAoaB7RWHb+GAsM3ApSHN/uLKHbbgIzSG9BDj/
	p3Cqd6bIfT0Yi9mkqefN/WGLxAum4rW8U/mrhHMMjgTZG8TBcpwenBQz6hG7/e5czuSoGZKDkkf
	nI4D6V/uhhGRtvWRVpNag8tUR2uHUQ0k2elhYENZf
X-Gm-Gg: ASbGncs3lw8rQTmFPS8Pf9XYUqooN57LXMEXk7QOGK76T3Vvi4OxbHX8YAsuKk9scN2
	Hw+DAIxDAjxj3nOPCsxpUEI7y+6g8oBgyqfSwk5/47G7BloSJvhaP9av02WD/PlvKeFHcl6Bg0m
	HN0IliLXByEoyt7U0OWXh/tWjXWkM5UJFXYYLT7U61xo3JcNMXWUVPCy0krm6wOY1jau1cwz9It
	49q7m3bFHSMKHPbmNfTE6Ggc3D2o5m12Iwm0NUHJrYA4Hg=
X-Google-Smtp-Source: AGHT+IGq9FT8VYoBk6o5AsaYR/ej2qoOKf/s46aBqSFWNQRwLIuU437Iw0sLKoZEgVPtCo4NpTCCwm5XD3z4rP5rAB4=
X-Received: by 2002:a17:903:3bc4:b0:25c:abb3:9bae with SMTP id
 d9443c01a7336-27ed4a474ffmr50710545ad.48.1758840062342; Thu, 25 Sep 2025
 15:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com> <20250920000751.2091731-3-kuniyu@google.com>
 <ddrg3ex7rbogxeacbegm3e7bewb2rmnxccw4jsyhdpdksz2qng@2xbs7jvhzzhk>
In-Reply-To: <ddrg3ex7rbogxeacbegm3e7bewb2rmnxccw4jsyhdpdksz2qng@2xbs7jvhzzhk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 15:40:50 -0700
X-Gm-Features: AS18NWCtvFTVjm_0W4tTSE27MsheFBXZtcWItJlaOgcJpCJH0tICXxG1j5ZeUgs
Message-ID: <CAAVpQUDxSwjegw1UgieGOF+YGF=j2_FK=M1ZEKP1KGdtCdEBkw@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next/net 2/6] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 10:25=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Sat, Sep 20, 2025 at 12:07:16AM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > If a socket has sk->sk_memcg, this memory is also charged to memcg as
> > "sock" in memory.stat.
> >
> > We do not need to pay costs for two orthogonal memory accounting
> > mechanisms.  A microbenchmark result is in the subsequent bpf patch.
> >
> > Let's decouple sockets under memcg from the global per-protocol memory
> > accounting if mem_cgroup_sk_exclusive() returns true.
> >
> > Note that this does NOT disable memcg, but rather the per-protocol one.
> >
> > mem_cgroup_sk_exclusive() starts to return true in the following patche=
s,
> > and then, the per-protocol memory accounting will be skipped.
> >
> > In __inet_accept(), we need to reclaim counts that are already charged
> > for child sockets because we do not allocate sk->sk_memcg until accept(=
).
> >
> > trace_sock_exceed_buf_limit() will always show 0 as accounted for the
> > memcg-exclusive sockets, but this can be obtained in memory.stat.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> This looks good to me now, let's ask Johannes to take a look again and if
> he still has any concerns.
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Hi Johannes,

It would be really appreciated if you have a look again.

Thank you.

