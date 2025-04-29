Return-Path: <netdev+bounces-186652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8AAA01B8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9261891126
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133720D4E2;
	Tue, 29 Apr 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q/gAZJ6+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1053A7;
	Tue, 29 Apr 2025 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904201; cv=none; b=B6Cwnggl2wA3UnuLBwYPTTMdTN9CWZYtK2ZvIlI3zkFKxJbeRh/S45LtmUg9Y4Dv4l2KFu+neIdPYOc19NcZBkO48HY9AXbWPmKDzYxCCDrBF5kz4PH7N5Dsj8sXWKPqjxeE4EEXk6qSedgtkhTFMYAPTEW3+JchmYXoUDi0u6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904201; c=relaxed/simple;
	bh=HiOtJxJOS45krxl+rXdVOJhoKOAGrcR1Z0Qi4OTbykY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndkXa4ZOaGy0cBeY+izGXqA1hhrluBZacKRluo6KN6KdbxeZnJfMR28gIJpbwSKjWL38AViHbm6DOKp1RhVK5e+/YcYt9hyKQDsxmZGkWatQI1QIFgKHiXG8clurgFgh/5HDpD3fTNlYkxCd9IPxeT00QiZom4OpIE7SsIgrJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=q/gAZJ6+; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745904200; x=1777440200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L5gjFUr5qsPK60vv0m8DA23aqaqW45pKAGmG+x4L5C8=;
  b=q/gAZJ6+hmdLpW/tjzGfowtjAUJOkVUheOT/HUhmT3xU6SeGhbYyIquQ
   6XjJ0LzqPZjomBvnjXuMXvf6uUmYqv23rFDisw/j/Ke8WMup/mgBTwCWK
   tjPSNV726ZWvETbV4nTnsmT4xXcSwxi4l/5glRWcrBepJB4WMpmiHofv+
   E=;
X-IronPort-AV: E=Sophos;i="6.15,248,1739836800"; 
   d="scan'208";a="493482829"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 05:23:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:53436]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id b565944f-2627-4c62-81c2-19d2c33a37c5; Tue, 29 Apr 2025 05:23:15 +0000 (UTC)
X-Farcaster-Flow-ID: b565944f-2627-4c62-81c2-19d2c33a37c5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 05:23:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.170.247) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 05:23:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
Date: Mon, 28 Apr 2025 22:22:56 -0700
Message-ID: <20250429052303.88052-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <89BC8935-21D1-45A9-AEA1-A4E52D193434@kernel.org>
References: <89BC8935-21D1-45A9-AEA1-A4E52D193434@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kees Cook <kees@kernel.org>
Date: Mon, 28 Apr 2025 20:52:59 -0700
> On April 28, 2025 5:43:05 PM PDT, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >Thanks for CC me, David.
> >
> >From: David Ahern <dsahern@kernel.org>
> >Date: Mon, 28 Apr 2025 16:50:53 -0600
> >> On 4/25/25 11:05 PM, Kees Cook wrote:
> >> > In preparation for making the kmalloc family of allocators type aware,
> >> > we need to make sure that the returned type from the allocation matches
> >> > the type of the variable being assigned. (Before, the allocator would
> >> > always return "void *", which can be implicitly cast to any pointer type.)
> >> > 
> >> > This was allocating many sizeof(struct hlist_head *) when it actually
> >> > wanted sizeof(struct hlist_head). Luckily these are the same size.
> >> > Adjust the allocation type to match the assignment.
> >> > 
> >> > Signed-off-by: Kees Cook <kees@kernel.org>
> >> > ---
> >> > Cc: "David S. Miller" <davem@davemloft.net>
> >> > Cc: David Ahern <dsahern@kernel.org>
> >> > Cc: Eric Dumazet <edumazet@google.com>
> >> > Cc: Jakub Kicinski <kuba@kernel.org>
> >> > Cc: Paolo Abeni <pabeni@redhat.com>
> >> > Cc: Simon Horman <horms@kernel.org>
> >> > Cc: <netdev@vger.kernel.org>
> >> > ---
> >> >  net/ipv4/fib_semantics.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > 
> >> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> >> > index f68bb9e34c34..37d12b0bc6be 100644
> >> > --- a/net/ipv4/fib_semantics.c
> >> > +++ b/net/ipv4/fib_semantics.c
> >> > @@ -365,7 +365,7 @@ static struct hlist_head *fib_info_laddrhash_bucket(const struct net *net,
> >> >  static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
> >> >  {
> >> >  	/* The second half is used for prefsrc */
> >> > -	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head *),
> >> > +	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head),
> >> >  			GFP_KERNEL);
> >> >  }
> >> >  
> >> 
> >> Reviewed-by: David Ahern <dsahern@kernel.org>
> >> 
> >> Fixes: fa336adc100e ("ipv4: fib: Allocate fib_info_hash[] and
> >> fib_info_laddrhash[] by kvcalloc().)
> >
> >I agree this should target net.git as the last statement
> >will be false with LOCKDEP.
> 
> Which will be false with lockdep? Unless I'm missing it, I think hlist_head is always pointer sized:

Oh sorry, now I'm not sure why I mentioned lockdep...
maybe confused with other code :/



> 
> struct hlist_head {
> 	struct hlist_node *first;
> };

