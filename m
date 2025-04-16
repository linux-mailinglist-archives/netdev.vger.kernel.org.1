Return-Path: <netdev+bounces-183459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F857A90BB6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89814601AF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512421A42F;
	Wed, 16 Apr 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JhhPxAg2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C75223703
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829729; cv=none; b=iJ5ZBk/ToZy7UpSPeNmOpVI6k1V5a8dN+QgzACYviSZwUVsBsBURnLLh2K9/Xs7Mc30ZxizWQZtgEj4RmJvwwuV3g/Arp5cQODtr+QpbWHK5QmONDXMlrSZenNji90FspTWacH3RHq5NgZH2eTNdWS9bnfN+f6BQ2uUbBClcA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829729; c=relaxed/simple;
	bh=um+ns6qYyiMLjk/JyzQpOUJUWAlMISEGZXrNde0mAEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDEAluvLWHSDpfbpTmWBbRtE2RYtidUaCnA8h5bikgmNO0NUBhs3ADnLxfW02dJkZvYZul94jO5r6ZkB1EeCqAyVaVn9QwCOME+a970sGeekFSRLiG1f4zINFD7Y0XFA9+GEb5TyQwelQvK6z7YtOfq9xRVWvXPFa9ZQDYw505w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JhhPxAg2; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744829727; x=1776365727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bty+KO36YewfqYFWfpGcm1X5fa3+wAC2caCPxBZsohg=;
  b=JhhPxAg2fnR5PyncJp/zF+cyWa0J7AgVZjmkRs6MJwOHdlqVn7eLzTy6
   mW94cnPxdwEiuRAAXRUl0xGeA7HEDNdPSMVDRS8yNVy8cfcAVSTUMppPd
   hSA+F/xq6lZSvcypAf+YYh493WqU7Lz4t4Buk7JSHIajLPNFHFPaMdAdR
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="191730597"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:55:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:23309]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.98:2525] with esmtp (Farcaster)
 id 10dd294a-84e3-4f00-a583-4aec76b9a2b4; Wed, 16 Apr 2025 18:55:24 +0000 (UTC)
X-Farcaster-Flow-ID: 10dd294a-84e3-4f00-a583-4aec76b9a2b4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:55:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:55:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 07/14] ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
Date: Wed, 16 Apr 2025 11:55:09 -0700
Message-ID: <20250416185513.1291-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <35c5934d-be33-45c1-b914-15f9a30e75a2@redhat.com>
References: <35c5934d-be33-45c1-b914-15f9a30e75a2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 11:37:54 +0200
> On 4/16/25 11:21 AM, Paolo Abeni wrote:
> > On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> >> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> >> index ce060b59d41a..404da01a7502 100644
> >> --- a/net/ipv6/route.c
> >> +++ b/net/ipv6/route.c
> >> @@ -3664,10 +3664,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
> >>  		goto out;
> >>  
> >>  pcpu_alloc:
> >> -	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
> >>  	if (!fib6_nh->rt6i_pcpu) {
> >> -		err = -ENOMEM;
> >> -		goto out;
> >> +		fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
> > 
> > 'rt6i_pcpu' has just been pre-allocated, why we need to try again the
> > allocation here? 
> 
> Ah, I missed the shared code with ipv4. The next patch clarifies thing
> to me. I guess it would be better to either squash the patches or add a
> comment here (or in the commit message).

Sure, will add description in the commit message.



From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 11:23:32 +0200
> On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> > ip6_route_info_create_nh() will be called under RCU.
> > 
> > Then, fib6_nh_init() is also under RCU, but per-cpu memory allocation
> > is very likely to fail with GFP_ATOMIC while bluk-adding IPv6 routes
> 
> oops, I forgot a very minor nit:               ^^^^ bulk

OMG (Oh My Grammarly) :)

