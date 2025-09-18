Return-Path: <netdev+bounces-213153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C467EB23DEB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4975F6265F8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC241A9FA6;
	Wed, 13 Aug 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dF5AdvKR"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF551BE65
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049785; cv=none; b=LnbwRYHW94d3YzqPNRqScOegBWxDKbsDvhf18x/Ux9pgI1sHSS9n8O100vceMQOg/JSLlUDzYzyItVGuGMAKYNRbaEipYBYiy8wfG6TSlIczM7fH1x72CNcG7lJEiVHUcHvCmOWmqprKnP1pghfi1Z3Xfs4bZGiRF7jVzwcQABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049785; c=relaxed/simple;
	bh=y8eBs0fHI7CmVwCx02H3JMhe4sR4fjcsdxnZfKRbvCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsuy15G3W0yxKSyQwUQjase4qlxlM7neYQe7d1gzgCw6MTOLHS2HFMWYHjCno+BsCWHQeF9d3WqzqZWe7hxP3xQjv/N+Tb1w7CN6m6zkbKjpS34sD8G3LdMJvAcdEjEIalrpyjgrEL6gaEOOIQNNVwk/a7wJrZJDP2unJSCXoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dF5AdvKR; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755049780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y8eBs0fHI7CmVwCx02H3JMhe4sR4fjcsdxnZfKRbvCM=;
	b=dF5AdvKR2ca/0Id6PcyQBrt5ubWxMZGHTzaPtosUH84mRPw/rz0ZtN0RXNgT+qna999apu
	RBTv6rLYEKBdLApJ1ypjDqATumzw0aXP/UyfSY5X9mPvS8YQph8ScVbB7RyO0vyJbiQD2t
	oCWzMrZeb/bNRLTfrs79xT2u9H5kJAs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de
 Bruijn <willemb@google.com>,  Matthieu Baerts <matttbe@kernel.org>,  Mat
 Martineau <martineau@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  =?utf-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,  Tejun Heo <tj@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Geliang Tang <geliang@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Mina Almasry <almasrymina@google.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  netdev@vger.kernel.org,
  mptcp@lists.linux.dev,  cgroups@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 09/12] net-memcg: Pass struct sock to
 mem_cgroup_sk_under_memory_pressure().
In-Reply-To: <20250812175848.512446-10-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 12 Aug 2025 17:58:27 +0000")
References: <20250812175848.512446-1-kuniyu@google.com>
	<20250812175848.512446-10-kuniyu@google.com>
Date: Tue, 12 Aug 2025 18:49:28 -0700
Message-ID: <87ms84q9cn.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> We will store a flag in the lowest bit of sk->sk_memcg.
>
> Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().
>
> Let's pass struct sock to it and rename the function to match other
> functions starting with mem_cgroup_sk_.
>
> Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

