Return-Path: <netdev+bounces-225454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB38B93C23
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0C2E11B4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46E1A23A6;
	Tue, 23 Sep 2025 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RLVvj/TC"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335718FC97
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588872; cv=none; b=eqJzcCTjjaT58p04jiS+YcicAUfvWbbJKh2rGYK4BRKwAilGtPOuPkQlm9N65gcXK4KxT0Z+WLWv9Eg0Bgw3yQE8Gk8U7rS/kZ0e8td+zZFgjtaWXThnU76IzrS4S9UXXwK0gGaNl75PqsX+YfZlbvPo4ue1/I6UOL9OWoBkgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588872; c=relaxed/simple;
	bh=cH8cB7MUaOsFskeCczK0vEO2HA8nvAXBQBQ1InPq7oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmL5nCtGgjQliGgsX2KJrBC7EwwdYv28H3P11U6oNfNtDrzxV4dqhqjZDay4SrRs/X4vYO0dG5QLv7IkCzBTUunvTtYVFw2WBoqXLXM7m6y/TYK9aAN+Xf6brFzs7brtNwLGtKX58M6NV14sE0Wyowdf2A17z6O6nNn6bTiIUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RLVvj/TC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 17:54:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758588856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wudc80E3D8qUTNG+QznXhR4S6Gy17+QjkwuFxCcm5RI=;
	b=RLVvj/TCoeZbKaGMqe4n0h6FRuVjrwrb5Z3ePJg++N21VuvPAFnsErVyM6QHUpdv0FUYSr
	uXRQMa9jwVq54Mkdku0KPEu/42lVuyN0xuQ/ha+zU6zu7+vWpNChYladVxHsdhLu9saBj3
	Wt9TDI5fTmue29TNopRXvtXsDylKXK4=
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
Subject: Re: [PATCH v10 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
Message-ID: <pmti7ebtl7zfom5ndqcvpdwjxlkrvmly2ol64llabcwfk7bdg2@mc3pigkg2ppq>
References: <20250920000751.2091731-1-kuniyu@google.com>
 <20250920000751.2091731-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920000751.2091731-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 814966309b0e..348e599c3fbc 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2519,6 +2519,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
>  #ifdef CONFIG_MEMCG
>  	/* sk->sk_memcg will be populated at accept() time */
>  	newsk->sk_memcg = NULL;
> +	mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));

Why do you need to set the flag here? Will doing in __inet_accept only
be too late i.e. protocol accounting would have happened?


