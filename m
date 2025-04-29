Return-Path: <netdev+bounces-186622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C6A9FE86
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B614173027
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5117588;
	Tue, 29 Apr 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hG94fIdr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060423C9;
	Tue, 29 Apr 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745887405; cv=none; b=dHitIW68yDt6ScRDaJXmJ+5V8MhS3+RFFt12/R/6WPPreOxiQFOlfjAoJh/S/tXr3d4f+z266CbZuEYz0JqvyRkDTjdM492A9eFlqGeW2vFgJ1YAFEg8Hc22kcN0O5xZa4Rmaf/paf5vUDGJUFg7ctRQMtVpdj45pPnohkwwHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745887405; c=relaxed/simple;
	bh=ffbDnE6nzwBuz6CtjG/SAu8YpndybmctbmVH1WdgdWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGI0Cu8wvUo4DIZ/gnr8ERF+FF1AERBWtTOZB11QfHg9TTNw6hKR9393iRHR2ev6H07PplI8OG48SAFJ05esGLAy1NpfG/prSeBP/0ck8WI8SQ6DNtcU0k/cuUMrzQqXgcZJ/4qNoht8k7yfQxNZOHVKVLE0I/wWWtiGzEUJSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hG94fIdr; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745887404; x=1777423404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhW1DRKDWj8lcyiPTN9PLmuFHcPD8VN1LkKE7OHphDc=;
  b=hG94fIdruJ6fNPDxls35nEYFrX8kh2GV4BFf1cfwWMyf2Lmx2PMYrdyT
   Tr2K9x0n3Ai/fZKb9YYAf87yQeWFcfuuvTsEZTnqKtN8qfJKGD6sVFgtk
   EH55aE//xLnbPf973kVP0o+ncGh8iRlXFhBvDbzzRi4nD2Yrx5eKXFaoB
   s=;
X-IronPort-AV: E=Sophos;i="6.15,247,1739836800"; 
   d="scan'208";a="195243743"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 00:43:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:29548]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 2f4567a2-c47a-4e6e-9c24-8ade236f87cc; Tue, 29 Apr 2025 00:43:21 +0000 (UTC)
X-Farcaster-Flow-ID: 2f4567a2-c47a-4e6e-9c24-8ade236f87cc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 00:43:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.170.247) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Apr 2025 00:43:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dsahern@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kees@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
Date: Mon, 28 Apr 2025 17:43:05 -0700
Message-ID: <20250429004310.52559-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <12141842-39ff-47fc-ac2b-7a72d778117a@kernel.org>
References: <12141842-39ff-47fc-ac2b-7a72d778117a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Thanks for CC me, David.

From: David Ahern <dsahern@kernel.org>
Date: Mon, 28 Apr 2025 16:50:53 -0600
> On 4/25/25 11:05 PM, Kees Cook wrote:
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> > 
> > This was allocating many sizeof(struct hlist_head *) when it actually
> > wanted sizeof(struct hlist_head). Luckily these are the same size.
> > Adjust the allocation type to match the assignment.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: <netdev@vger.kernel.org>
> > ---
> >  net/ipv4/fib_semantics.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> > index f68bb9e34c34..37d12b0bc6be 100644
> > --- a/net/ipv4/fib_semantics.c
> > +++ b/net/ipv4/fib_semantics.c
> > @@ -365,7 +365,7 @@ static struct hlist_head *fib_info_laddrhash_bucket(const struct net *net,
> >  static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits)
> >  {
> >  	/* The second half is used for prefsrc */
> > -	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head *),
> > +	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head),
> >  			GFP_KERNEL);
> >  }
> >  
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 
> Fixes: fa336adc100e ("ipv4: fib: Allocate fib_info_hash[] and
> fib_info_laddrhash[] by kvcalloc().)

I agree this should target net.git as the last statement
will be false with LOCKDEP.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

