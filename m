Return-Path: <netdev+bounces-183456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41319A90B9B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF9F3BF6D0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B186224235;
	Wed, 16 Apr 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R16bdbkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1222370F
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829342; cv=none; b=u+i2VNOLmRmeDuEX84Qpviit4NSCYGQrhjEaLev3NEHAVfCGg/A3oBK/b8LU2s0WAgG+FsO3iFhCh2bRra5vsJdQgJf+2GlKOjx+JYWrqseeTCbVTTrTjLkwapiOx3QCLsl7rX43PWevypI6UyxJ985P3AKWjzW1jEIdK/mrFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829342; c=relaxed/simple;
	bh=1Leac6S+eSmEK3qalqvuf7i3H0x+mClKFoKhT2+yjKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2MuKaXJ5tBd3RR5vD+cW5TeRxEZzMkm9DdtWpnB2mdbz+cPrxxxSKDc5OiFOnrlA10dMXb0+LZNoYkGgEVpB5g+kztORh5pZICbLyPHHpUN9Xyi78nYCP1yH5lF3/qDHzBct881BSU+NtzCgYAko1vwvQU17SaLqXDgXnEkvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R16bdbkw; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744829341; x=1776365341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QughziUKnssA9EYlDJ0qYacigZpKcNnqKhAT0i2yDH0=;
  b=R16bdbkwDca7Om3eL474Tk0JxxxnYixyNJnZoqumxMt/+TU/93LaF8St
   PjhiqSXtluBTkgRLXWGbCm566o+4RmDgMJYNmwMnPtUzg8cA+3g5ehwCi
   nAwgmBmvUzgaUbCTwW2/vrKaDRC3S+bTX+mU8f2a6BiqK5RqTWVziY8bw
   E=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="396467164"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:48:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:60961]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.154:2525] with esmtp (Farcaster)
 id 143b69cd-7e9f-40f1-a946-007d4d80c421; Wed, 16 Apr 2025 18:48:57 +0000 (UTC)
X-Farcaster-Flow-ID: 143b69cd-7e9f-40f1-a946-007d4d80c421
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:48:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:48:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 04/14] ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
Date: Wed, 16 Apr 2025 11:48:43 -0700
Message-ID: <20250416184845.293-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1c382acc-d823-47e9-902d-42606d64daf1@redhat.com>
References: <1c382acc-d823-47e9-902d-42606d64daf1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 11:06:30 +0200
> On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> > In ip6_route_multipath_add(), we call rt6_qualify_for_ecmp() for each
> > entry.  If it returns false, the request fails.
> > 
> > rt6_qualify_for_ecmp() returns false if either of the conditions below
> > is true:
> > 
> >   1. f6i->fib6_flags has RTF_ADDRCONF
> >   2. f6i->nh is not NULL
> >   3. f6i->fib6_nh->fib_nh_gw_family is AF_UNSPEC
> > 
> > 1 is unnecessary because rtm_to_fib6_config() never sets RTF_ADDRCONF
> > to cfg->fc_flags.
> > 
> > 2. is equivalent with cfg->fc_nh_id.
> > 
> > 3. can be replaced by checking RTF_GATEWAY in the base and each multipath
> > entry because AF_INET6 is set to f6i->fib6_nh->fib_nh_gw_family only when
> > cfg.fc_is_fdb is true or RTF_GATEWAY is set, but the former is always
> > false.
> > 
> > Let's perform the equivalent checks in rtm_to_fib6_multipath_config().
> 
> It's unclear to me the 'why'???

It's just because this validation does not need to be done under RCU.
Or are you asking why I didn't use rt6_qualify_for_ecmp() ?

