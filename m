Return-Path: <netdev+bounces-211124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE8B16A9F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 04:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A775B18C3AF0
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 02:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A961B423D;
	Thu, 31 Jul 2025 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qODRXZlu"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37DA15383A
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930734; cv=none; b=HTG1reZNzP7SoclpQ5KEYhgGPRNsLGyC4QO+dOhinQwPrDPLypZ7g060k6XLgSmkzd+o0duFz8LR+uyP1RIfbSftV2ZYlIkfXabhWacBFk1S2O29OkvuSrt3TT+ngr0pcMiEpErmWgL+fy22SJeDkxBurFjyoCj/TLAM+3sQy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930734; c=relaxed/simple;
	bh=hO4jQq8PLpE3srsD0rPnbC1MtEeo3jkBhYPUfq1jFi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKwvekzmNHVzRrXPy2cgXxj7lxlG3bPDphTdqXIIM5c01tMbIwWwa6LvwjkthgFOsp2xBcSl9L80hstO/7aUG+4eegaworlolkV9Eay06TO+VIyH0dA/68L0Bpkfq+Oe+Rs55G98oAEcQ/QjeKe64g109YN60D+cpmah6c53Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qODRXZlu; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753930720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hO4jQq8PLpE3srsD0rPnbC1MtEeo3jkBhYPUfq1jFi8=;
	b=qODRXZluoTdZwsqIuRfPB+EmJlGTteKL3nnL/Ucebe10AjPqn+1D455FmrTHJPFgnZI0Jh
	JMNnJ6aM2zKV+49b9RReayHJAoHS8GgGkLFGaAFI3DdlOr+/X3+3i7whoAoR7V9v4nUV5l
	Lb4LEniPT+7zzehE3Z3mfWCDC1JYkBE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de
 Bruijn <willemb@google.com>,  Matthieu Baerts <matttbe@kernel.org>,  Mat
 Martineau <martineau@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  Simon Horman
 <horms@kernel.org>,  Geliang Tang <geliang@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Kuniyuki Iwashima <kuni1840@gmail.com>,
  netdev@vger.kernel.org,  mptcp@lists.linux.dev,  cgroups@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com> (Kuniyuki
	Iwashima's message of "Mon, 21 Jul 2025 20:35:32 +0000")
References: <20250721203624.3807041-1-kuniyu@google.com>
	<20250721203624.3807041-14-kuniyu@google.com>
Date: Wed, 30 Jul 2025 19:58:32 -0700
Message-ID: <87pldhf4mf.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
>
> Even when memory usage is controlled by memcg, sockets using such protocols
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
>
> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
>
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
>
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.
>
> Let's decouple memcg from the global per-protocol memory accounting.
>
> This simplifies memcg configuration while keeping the global limits
> within a reasonable range.

I don't think it should be a memcg feature. In fact, it doesn't have
much to do with cgroups at all (it's not hierarchical, it doesn't
control the resource allocation, and in the end it controls an
alternative to memory cgroups memory accounting system).

Instead, it can be a per-process prctl option.

(Assuming the feature is really needed - I'm also curious why some
processes have to be excluded from the memcg accounting - it sounds like
generally a bad idea).

Thanks

