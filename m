Return-Path: <netdev+bounces-213149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFACB23DD9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1B2189C72D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB637189F43;
	Wed, 13 Aug 2025 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="evfVPnTg"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B613BC0C
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049613; cv=none; b=cSQYKbSU1mKCTs2G6+ClL5uFp5U8Fihe9dG8Fvvx2i915XQTRKPXdKE2biemshEYUrgN9xHpca7HDkimxhSP/uS831/uNhxIsNPu7a8bjVWjclu2hFMQj7vhYw2WSlzSJxlLWlEZl++AJPiFpkP20QZIj+0UkG8uPuxoOyW76zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049613; c=relaxed/simple;
	bh=8cimGdearmvYVQCy5FWmG8x9rA0b5/NI1ufddvwaDAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZ/EcWIuK466nrJGFP794h8Hds0USx0NOYNOOQq+laRgjz0QG5Xk89GK6NyH+L3Sx4Ap/t2TcD8gY7u4h/7jlOc6GbjVds2q37YHAbEQ/ZcBn8Zcq9LeghPvTvLtAvx+oOSGZxFOW79M5pUhDUsWAfHkMHrLc+RdQfNVtfNmTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=evfVPnTg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755049599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8cimGdearmvYVQCy5FWmG8x9rA0b5/NI1ufddvwaDAw=;
	b=evfVPnTgHBhA7AgQGRCHcwiqrgOLYAmg6DPpQQtrxVPp8a6y8pvPbiBeqN3gS8rxKUoiLV
	TCqpB+VncP3f1jKieCNBCXbddW8YQuRWO/bJfrbxAr50x0SFMoB9a8FCZZSnKP+UM+hKI+
	Jyy1cHE3qlMr1nyxI89fKAUrUQM6YGE=
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
Subject: Re: [PATCH v3 net-next 07/12] net-memcg: Introduce
 mem_cgroup_sk_enabled().
In-Reply-To: <20250812175848.512446-8-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 12 Aug 2025 17:58:25 +0000")
References: <20250812175848.512446-1-kuniyu@google.com>
	<20250812175848.512446-8-kuniyu@google.com>
Date: Tue, 12 Aug 2025 18:46:29 -0700
Message-ID: <87y0roq9hm.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> The socket memcg feature is enabled by a static key and
> only works for non-root cgroup.
>
> We check both conditions in many places.
>
> Let's factorise it as a helper function.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

