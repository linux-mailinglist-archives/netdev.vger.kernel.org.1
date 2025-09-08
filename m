Return-Path: <netdev+bounces-221003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC222B49D95
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7B33C5671
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C82311948;
	Mon,  8 Sep 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPGLRtmR"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD630F80B
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375251; cv=none; b=OKgKs/yg+u+NfagbiwLcCVw57aXbpgbiBxRqPgif66Ku9gR8O+uwUzoKW/hbHUa4B3Ph6Gsg90uR/m2zaAsY9MKTMuhirMPweUopDNCgxwinzGWGBAtiiGCuEyPqWPQdaUWmisyDYWoXouOOyqMyo5mBpSHSQ1mMd08Mi7YgsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375251; c=relaxed/simple;
	bh=q1ER7gDoA4x6IZ7pfkSWkGtETgvajaNtFOWurHrgXdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pabab9iixTn5Ai/37Txd6MhNpQvYBKLgsV1/JkylIHWYEia1Hjv6mFaZ4EmWcupjuhFlQpO5VRGjRdbfEe3yyaj+vinntJ7uzUYxj3QupHesEuD9RMVMcbD0g0BOGa0YWE8cSj0yv/x7Yk6JyEES8i0YesPa0v0RCqYFV5xJCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPGLRtmR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 16:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757375246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GdO5Ik5DdKg1en7IAmX+24J5ronGxFcNC2FfxFXISfU=;
	b=DPGLRtmRTB1B5hWhyLpQwhu5Gu9Z4SiCMEDUJ1V8j93IUI8UEawYx+59PdX0N/SYhrf0Wz
	FCqf9r6StosmVPLSMfl9DTf1bNjpnL8c4BEbFDsmhWlns2XK4pJlKgHGlr5yqgAYbwx8ez
	Hj/pc+DcLMdYlA6tkU/Zd1HzOOZup1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from
 sk->sk_prot->memory_allocated.
Message-ID: <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
References: <20250908223750.3375376-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908223750.3375376-1-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

Let me quickly give couple of high level comments.

On Mon, Sep 08, 2025 at 10:34:34PM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) have their own memory accounting for
> socket buffers and charge memory to global per-protocol counters such
> as /proc/net/ipv4/tcp_mem.
> 
> When running under a non-root cgroup, 

Remove this non-root cgroup as we may change in future to also associate
with root memcg for stat purpose. In addition, we may switch sk pointing
to objcg instead of memcg.

> this memory is also charged to
> the memcg as sock in memory.stat.
> 
> We do not need to pay costs for two orthogonal memory accounting
> mechanisms.
> 
> This series allows decoupling memcg from the global memory accounting
> (memcg + tcp_mem -> memcg) if socket is configured as such by BPF prog.
> 

I understand that you need fine grained control but I see more users
interested in system level settings i.e. either through config, boot
param or sysctl, let the user/admin disable protocol specific accounting
if memcg is enabled.

Please rename SK_BPF_MEMCG_SOCK_ISOLATED to something more appropriate.
The isolated word is giving wrong impression. We want something which
specify that the kernel is only doing memcg accounting and not protocol
specific accounting for this socket. So, something like
SK_BPF_MEMCG_ONLY make more sense.


