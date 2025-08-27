Return-Path: <netdev+bounces-217510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1260B38EDC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5841B22608
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491030F94E;
	Wed, 27 Aug 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iz/LHZg7"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD321B6D08
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335417; cv=none; b=F1xULPiHDxNQNGkiQDlVlPRGHOyXQLjgB6wouMZD5inqd82TqThcdWyFXeE3NVPOpS5qa58sYUorS+QOAUfOEdca9EG71Fnh4eko5TLYLi+xK9H+e2W+dFPvsqn2aKaq/ahepq/9s84c1z/fWSz0c2eW1tmGxrS8mu8/C8jSp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335417; c=relaxed/simple;
	bh=xiJ9t1YTeu5ZrEO3m5CG16pNsyQ7nchDIi6+OGCjuqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxZayQ6YwIgdgP+RbkcEC6a7/Uwwl8ehgROnwLutC5JhQsJY7dBHfzDu+NVCqoUHke1ipAKVuxDHLhOfmB0XoEzyg7rb3GAq3h3VH2SEL9un50o+x7zisN0pFgU3/WSBdZRK1QjKnPUVgU1RCWYp0UBwXJQYW09o5isG8qXhrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iz/LHZg7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 15:56:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756335411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+DB8on87O7/Jsub/24/qL1zUQyKqLuPxag6cDd5BO4=;
	b=Iz/LHZg7Q4XSIsFkoIrvlTZJKlwZ9Xm6asORzo1uuzODBgehuKkE226OXe6v0fH10l55Ie
	DGis3u12eVrYufEBdsHRkBdACjgTig4uJPsonCnwsN6Gzscdt9ZQxQHlCF2Pb8FQ6QX7aZ
	ULxsFkygqKb3msoUTo+oq+dnkrPmGDI=
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
Subject: Re: [PATCH v3 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in
 inet_csk_accept().
Message-ID: <f6bop5lyqhzmmtbca7kyw2vxhmeji6kgntcjjrsl345c5napwu@utckuhl3pnt5>
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826183940.3310118-2-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 06:38:07PM +0000, Kuniyuki Iwashima wrote:
> If memcg is enabled, accept() acquires lock_sock() twice for each new
> TCP/MPTCP socket in inet_csk_accept() and __inet_accept().
> 
> Let's move memcg operations from inet_csk_accept() to __inet_accept().
> 
> Note that SCTP somehow allocates a new socket by sk_alloc() in
> sk->sk_prot->accept() and clones fields manually, instead of using
> sk_clone_lock().
> 
> mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
> so I added the protocol check in __inet_accept(), but this can be
> removed once SCTP uses sk_clone_lock().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

