Return-Path: <netdev+bounces-214226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A70B288CD
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CEC1898EB6
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB72820B6;
	Fri, 15 Aug 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VqNZM3WV"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC523D7F4
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300783; cv=none; b=NCiU2499rUDxBpECQydsX6lJCNXeEt/juhLbuPkYFLvxroW9m23W6ztvb3t8B8AYR1aRD6aEzKgXjW8paNYw22n4/qRnTz+zxWy1nj9eyZ4VMqIoVY+lUwTF3K2tP/7xpj3zKqNXRlqwuIa+9UKFX1pvU6PzjivimMPv8NdT9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300783; c=relaxed/simple;
	bh=H0tadr0xTM+W0GzQmg1abUwYMljwYrKCXvZb3D/4XeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8MzuWFZdOeJFuURCJ3E4nphV95SQ7VkfGEUzTu02V8pPHW6SXDcbvORGQGezhzQIHrUV5te9L+BCb/uCFZxB3wbQwPmDNHvPjTf7s6HEF6OLXXQy3+Nv3P+YpaL4kLq9quZfOxRyrQVDKdkM2kLcZ4rdLm0I1hyGzO5zSE1kYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VqNZM3WV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 16:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755300769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXLIjULjHIbwG6bxUtOeWzsAAQ+xy0b4gmrNOnGTqG4=;
	b=VqNZM3WVNHiEwegbdEeOrBiwjv+u9KHv1mwrE2FQPW3BrRaLz3tbXZPdXM33SVSh44czJi
	UaD2eXhYLBJRfn2PbG+xXhnRrI5UT8RtcxsBjT+d2ZEUkl/7n3YD8wkxvW3lEbs0dxeJIg
	10j7dSS/lFi6xMyINEXBJfa4uB79F70=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 net-next 02/10] mptcp: Use tcp_under_memory_pressure()
 in mptcp_epollin_ready().
Message-ID: <j4npjivymessz7rnlc7xvec77k7634b4ldfrd2to5zpcgofci4@5adfxbs3hcl3>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-3-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:10PM +0000, Kuniyuki Iwashima wrote:
> Some conditions used in mptcp_epollin_ready() are the same as
> tcp_under_memory_pressure().
> 
> We will modify tcp_under_memory_pressure() in the later patch.
> 
> Let's use tcp_under_memory_pressure() instead.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
 

