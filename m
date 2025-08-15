Return-Path: <netdev+bounces-214229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EABB288F0
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DEEAE3E95
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9F283FF4;
	Fri, 15 Aug 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dtc29LYM"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076D280CC8
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301984; cv=none; b=m8UGR/KYw0nffuqVyLtNLIma7KFzFFIs8lf2VlLvjm2yUfRWgvGbmhXYdD2KwUcAzXMtnhTD1AUPrKKibk+JHZ88/97sWYT7m80L3J+XahfraVG4dwNO3kfTLG7T6npOGmVu0KJuignD1fyM011CzIwm31FheTw6ARl51T3oohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301984; c=relaxed/simple;
	bh=DwhAXyRjwbbyTokqiNuVIVxgm2HNQRbCisfELT54B5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQZZl3THh3tLsH/SToON/ymzFDXBJ6UuTYp4oDtc1NNGnc/JXHGx6yJpQOiBGJuLex6fbfOpLT8IbBVIvO5nUmlbMs9MOwthEj2uuE8tb2GRKDShnYwCEdLs9o7X0Rnw8iSJ6TAI+JmlyNHNkGjL4/PJWZ4uKykAZB1k1rFUMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dtc29LYM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 16:52:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755301970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44mrTSttEiykRrZrwK94sCaa7posB77laqbOo+14xpM=;
	b=Dtc29LYMtA/hYmueZXIsJmfMnkavasnCVPDJHF3t9HUseuMaeHO/I9+XMGcy1dd5Di3tAR
	z0q5EKjvP/AqSn7PrGOGunGBOrSSw0noHpc4QA0/sLDYOUKHzqJRU+/NPRnaoIbhCNJ4qw
	ENJpET8DF5R6dD8KrMALzgQIYWjwpC8=
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
Subject: Re: [PATCH v5 net-next 05/10] net: Clean up
 __sk_mem_raise_allocated().
Message-ID: <ntttvqtkf4epnw2cstpjvdrokzkhgjcc42asuxrmoesk2pmvw7@hvnlluilnvbc>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-6-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:13PM +0000, Kuniyuki Iwashima wrote:
> In __sk_mem_raise_allocated(), charged is initialised as true due
> to the weird condition removed in the previous patch.
> 
> It makes the variable unreliable by itself, so we have to check
> another variable, memcg, in advance.
> 
> Also, we will factorise the common check below for memcg later.
> 
>     if (mem_cgroup_sockets_enabled && sk->sk_memcg)
> 
> As a prep, let's initialise charged as false and memcg as NULL.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

