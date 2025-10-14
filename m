Return-Path: <netdev+bounces-229286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963FBDA16E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55E944E4727
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC52FBE17;
	Tue, 14 Oct 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N7PD/BUD"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908892F6194
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452698; cv=none; b=GpzmMAWG+GWXEer/Y2TeKzWHzmcEXfr33fTojuxBlFDGnxJfmIpV/bra3dC9cNrtITlf9C8lqDFj3MsCDUHtF7qwJFq7dyDphCxTYGN/Ayj8f33fcLTqbFIoYpZJFy3nHD4pv/eBISwGFcjZlylDqNCCr5fJbP1gEzF7apTCmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452698; c=relaxed/simple;
	bh=VmZbhs3xevNRT7QCNeeCFCNlM8H/SQbw3GEXhb4kOs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwIf5XKaWfSYiLLicc0nxJSE2KZojc1dM4+0acgbIathbGTtRC3LyKf8lb8OPtT8P2Z/MzPvuf59oXZM2vCpoD6cvkGRBCYwW8M/f1zRJAaPK0eHlXQ0gRaFnqsOwSHR+Jwd5jZ6rc7GNbpMIlbnX1R4nXtMYns5LgvXtXPZG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N7PD/BUD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Oct 2025 07:37:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760452684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+WxWTN/C2HyVblMAccwywFAotrd7QpsKNQRxf1sI58=;
	b=N7PD/BUDXc/bOVA2AS0yKahxhqfyPMfGVj13erv8XHxrFxgs9quAQp7uIdx7ICDzbZMTS6
	/pd4lzjh4mPDJMpa+8NUiKnRE6quyJb5WjesKAC5YmqWv0+fbd8lZDwA3zzAFWkaSNd/WK
	yqDMrA9ChLKXKNM0Q+XNxGFRKTJ5ncs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Barry Song <21cnbao@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Jonathan Corbet <corbet@lwn.net>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <pow5zt7dmo2wiydophoap6ntaycyjt2yrszo3ue7mg2hgnzcmv@oi3epbtyoufn>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
 <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 14, 2025 at 06:19:05PM +0800, Barry Song wrote:
> > >
> > > >
> > > > I think you are missing something to control how much memory  can be
> > > > pushed on each TCP socket ?
> > > >
> > > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > > >
> > > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> > >
> > > # cat /proc/sys/net/ipv4/tcp_wmem
> > > 524288  1048576 6710886
> >
> > Ouch. That is insane tcp_wmem[0] .
> >
> > Please stick to 4096, or risk OOM of various sorts.
> >
> > >
> > > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > > 4294967295
> > >
> > > Any thoughts on these settings?
> >
> > Please look at
> > https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> >
> > tcp_notsent_lowat - UNSIGNED INTEGER
> > A TCP socket can control the amount of unsent bytes in its write queue,
> > thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> > reports POLLOUT events if the amount of unsent bytes is below a per
> > socket value, and if the write queue is not full. sendmsg() will
> > also not add new buffers if the limit is hit.
> >
> > This global variable controls the amount of unsent data for
> > sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> > to the global variable has immediate effect.
> >
> >
> > Setting this sysctl to 2MB can effectively reduce the amount of memory
> > in TCP write queues by 66 %,
> > or allow you to increase tcp_wmem[2] so that only flows needing big
> > BDP can get it.
> 
> We obtained these settings from our hardware vendors.
> 
> It might be worth exploring these settings further, but I can’t quite see
> their connection to high-order allocations,

I don't think there is a connection between them. Is there a reason you
are expecting a connection/relation between them?

