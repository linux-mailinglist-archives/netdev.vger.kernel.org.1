Return-Path: <netdev+bounces-214227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D9BB288D5
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9695E1CE3DE3
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D2283C8E;
	Fri, 15 Aug 2025 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1KSa3iP"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388B21FF5F
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300960; cv=none; b=gRmkJyOWmEyAaOBWD0+qj9EU0vfprbeSVnxYr/u0sdvkxuQ4tfLtW53pUlj1sk5cpfpBfIrYQQN7aiu+PrgWE3nuBV2JSRresKQ0ciSOa50o9TsIVpI39iR5Go4ww1RiCLd1WiKJ5Q4smjOgXTXU2LSJlMvMPUUiJRtPXgh5e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300960; c=relaxed/simple;
	bh=SvwHZHmtWJOIEAJLv2iF3ywLI6i1X93RNzFGEnQYfZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYKZuC2AkfLZm28bJVdNsqN2NdoVrmdxJYnPnsmd+oGdXy7GPzQO93nGBUuuPNTvOiDBakOSFYBXObE/3YYkMkaWR7bjOpfDp7Vm04lJMWwH41G3wCxmvb/Mi+qnboDXLda5JQUoufbeG4fYUZ/2q5YWumIXyZtJZtMpp1d2fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1KSa3iP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 16:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755300957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcqbcpR+PPLolCotgvnuTTzNHDIi6DR9EnEVb+T8qy0=;
	b=I1KSa3iPECj/Wsi8SDf6g94yBfaB/ykJX7hBJxYk/MeurOgwRt3Sk68DV1gE7JOrcJSbcY
	sS3o3rH35F/X4THaHv0DGoc/9gWC8z4FmjfuNHO+JP535625SiUr+N62DFZU/dW5FX3q2H
	0O9H5Qfvt9jxbHkzIs+OHmZyUXbeSCM=
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
Subject: Re: [PATCH v5 net-next 03/10] tcp: Simplify error path in
 inet_csk_accept().
Message-ID: <a53fhshvazugtmvszdak5j3arzpf2dkiqy227bredme6drt7cj@5vlq2zyeyv3u>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:11PM +0000, Kuniyuki Iwashima wrote:
> When an error occurs in inet_csk_accept(), what we should do is
> only call release_sock() and set the errno to arg->err.
> 
> But the path jumps to another label, which introduces unnecessary
> initialisation and tests for newsk.
> 
> Let's simplify the error path and remove the redundant NULL
> checks for newsk.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

