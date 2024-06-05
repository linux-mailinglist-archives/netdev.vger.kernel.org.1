Return-Path: <netdev+bounces-100931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E38FC8D4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B6F1F21A5E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72039190071;
	Wed,  5 Jun 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LO46pJCT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F61946D5
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582843; cv=none; b=R7W06j/FyXGEwIOtl5CmZ7XeUGWuXPEwakcewAU9oRvuGYPNCBS+WXmKu7N/e3J8kbpMMfWgNM6HGGD1TPUhW0ZoE19VyTGD0+/ilVJ2IV61t0SMeIMIOM27MG7RRWHKxY1+r0iFYNP7DijijVz7uLyOkOnj5Srcz0KA/0QjmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582843; c=relaxed/simple;
	bh=KchsD3JnU7DsaQ4R9YN5x/kCx7wa+/YGiI9tYcQcRYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DifwjiDfEqUx6y+B8chzCBIKueR8lz4vKfupmuCOmEkAjtdJZQxNKFYXVOXKKIwZC1t0/wzyv7NgodZlgKn5Sd5I9RrMkdVcZPQKar62iM3lslZwJiBMZxPV4PxIMY7/s2OwbIM3QZnVYfNJqF3N9zkoHQ7vONiF0OpttviIQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LO46pJCT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717582840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjjkFcz5nt2P4PDLXs8EVX3oErPCvXtoE8dmYvaKaqI=;
	b=LO46pJCTUWaC6D4sGBoctRU7fYE4XNVYlAFv4WW+XANX0iRC02gk+2NcOoVDTVjjAFAq6B
	OqHm9SR6AhMAwtxgF3SHY5A0we66GD/xzPwxunrtLQOa1ikRI/9nqew/5mnQ1FpEAjbFFq
	m0KtLawRUOOiGCWrjqMvaYqwVbKTJ0s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Dc9eo1wtNdmWXUcNSKMbLg-1; Wed, 05 Jun 2024 06:20:39 -0400
X-MC-Unique: Dc9eo1wtNdmWXUcNSKMbLg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7025fafc37eso824586b3a.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 03:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582838; x=1718187638;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjjkFcz5nt2P4PDLXs8EVX3oErPCvXtoE8dmYvaKaqI=;
        b=wiQFCy8+3O6Gql/VcOTi3PQcJNlrbM5acr0054NJ4QMOBAD/67Wk0JLIE1allCBX9k
         4yZZ7JBc+bSzUDwWdbObpwKRnCJTemcGVtq3/yFWnqfEybzjxtAh9JCvvtJ7FcA8jfdZ
         xt6kUjCwkgeKXJOinRPfqbYadr7215ZcWQ6MbE6184yk9WE+vIAEcJb9P9BVm9erezxz
         NnQqi8D0/dvCLHnLRNGu/3f9N9ApcCYQHm856uvl+PkjsWDfr5tFC5S82kUaag168jtu
         C/ihPWbM2FoRTeViuQ5Tq/Otxd209ZU2SYaRCvFg2oogohjdTJVTOp9huM2t/ciZl5BT
         6j9w==
X-Forwarded-Encrypted: i=1; AJvYcCUNzf0sLIA36i4NEqEp6rIXJbTkBU9K9nvwrP1lMFKN69ddEGbDDME/udys26gzWYuB1GTlKSBLtW3LrBeF7VFnwg8CrUjz
X-Gm-Message-State: AOJu0YyoLcaSc7/+IyaukISOJ/gpwitzjzwf2yv7Hxe2vJvGGB/xcwu9
	B55Wy73biZBkwnAlh78sXhJs0ksA/Uwbp2QDmYY5EZSMNkLTZJLcMlNTX5SYmkUcDxRbIkvXVLJ
	d+1UHZrrK/nz9ZtOGdyM1Sv/YiFqBSUcPl8vLwiS/VWbkUxJK3JsdpQ==
X-Received: by 2002:a05:6a21:328d:b0:1af:fff9:1c59 with SMTP id adf61e73a8af0-1b2b6e2a25amr3331617637.2.1717582838324;
        Wed, 05 Jun 2024 03:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJfsc5Ha+Gm0UXE43JB22hMLFqLZJcDbQGdzxVIlVgK2HPL3ko4zVMM+J1PrkIsbsUAbmdpQ==
X-Received: by 2002:a05:6a21:328d:b0:1af:fff9:1c59 with SMTP id adf61e73a8af0-1b2b6e2a25amr3331590637.2.1717582837895;
        Wed, 05 Jun 2024 03:20:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2c586sm8356415b3a.188.2024.06.05.03.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:20:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4AE7C13854FA; Wed, 05 Jun 2024 12:20:32 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 13/14] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240604154425.878636-14-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-14-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jun 2024 12:20:32 +0200
Message-ID: <87frtradxr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
>
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
>
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
>
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
>
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
>
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it. Use the __free() annotation to automatically reset the pointer once
> function returns.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
>
> On PREEMPT_RT the pointer to bpf_net_context is saved task's
> task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> variable (which is always NODE-local memory). Using always the
> bpf_net_context approach has the advantage that there is almost zero
> differences between PREEMPT_RT and non-PREEMPT_RT builds.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


