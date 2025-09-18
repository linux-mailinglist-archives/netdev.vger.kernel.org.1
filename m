Return-Path: <netdev+bounces-213853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73B6B27175
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8341BC5A59
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393C27FB0E;
	Thu, 14 Aug 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VhdoxPU0"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54CF27F18F
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209424; cv=none; b=ujLitMMthCKpx1Yllk1jc+wRWLXiNc8GsaqMUCN6sp97RWimAFoPjgjiM2VOaZsxpw6skWL9RelYT2MN5khLBTNEeU75rOs9q6cFoDppJAKM16E3MlPFUUKwbl+/KlXQ+zvzZjEZpdiSf3b4oiWljjhKCbGmL/hFCPePviwFD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209424; c=relaxed/simple;
	bh=xWKpq6/7FMCgEUrQvEUPXtwBwov49DGQUVDfhv49FkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNI/szWfmEf6D0GflBg0EB9A0IVq/IN7iaCVgj9Oy0UhC4Yrqm3P7I4NU0dDntzeD8q38Q3FzLD+afbrCt7duPXXhwFqQnQ6GF+1AetUYgvFYAKWxp8iVhXQJR47yOFnPd+XbgkPNSkaQ9FU8Zwx1wlC1MWzz3M0Fy0bwMXWBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VhdoxPU0; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 15:10:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755209420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7tFtXLy/+hhaWIDVXL9aY1SXSecuce2Q61K8VuI8ts=;
	b=VhdoxPU0shDMzUuoEFJUozEMykYZnj/jMFq56KuQnofRodUyq7TJLbUc4zeDCCEXieJfcr
	0G8fbwWPp012WugCEUb3Hx3RzB6Ktl920jhFG7T87bVom+4MbHGkDKTWokB08Hbc9IQs/P
	ol0QxVXY9OiS6yM4O7MxX70nS3cc5Hc=
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
Subject: Re: [PATCH v4 net-next 09/10] net-memcg: Pass struct sock to
 mem_cgroup_sk_under_memory_pressure().
Message-ID: <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-10-kuniyu@google.com>
 <pl47mmcmxu53ptfa5ubd7dhzsmpxhsz2qxpscquih4773iykjf@3uhfasbornxc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pl47mmcmxu53ptfa5ubd7dhzsmpxhsz2qxpscquih4773iykjf@3uhfasbornxc>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 03:00:05PM -0700, Shakeel Butt wrote:
> On Thu, Aug 14, 2025 at 08:08:41PM +0000, Kuniyuki Iwashima wrote:
> > We will store a flag in the lowest bit of sk->sk_memcg.
> > 
> > Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().
> > 
> > Let's pass struct sock to it and rename the function to match other
> > functions starting with mem_cgroup_sk_.
> > 
> > Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
> 
> Please keep it in the memcontrol.h.
> 

Oh is this due to struct sock is not yet defined and thus sk->sk_memcg
will build fail?

