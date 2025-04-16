Return-Path: <netdev+bounces-183457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CCA90BA5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60F54483E5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A817221F34;
	Wed, 16 Apr 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AJBkt4XT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6E221F32
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829438; cv=none; b=hC8kkONSyg2UwO8pVwLVK3RAQbr0MvBHZbSm0/RPnAB3KWDdqfYlvyX0A4LjlBPVYrt8ZZ1M/b3/jJlTNUq5TdxwAhv00o3UShlJW7pZrokDNyk1li9WU8yyYhE6cp5QXdYAK3TmVZwnbsPAxqvGKtS82WsFcU9lO05oDWP+skY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829438; c=relaxed/simple;
	bh=RQRZE4UcNr0FROLjRO41yEPlDd3RHCdNoIycTsYZna0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSx71K1WcAzjFZAweksbohf1u9w6j2weE6jHQHbYFSWtE5VUnCE7/cItWPkwjch17GAT8SUiaQ9Rsv1Xj3eXVOSmK07qZ3GSVvPWYq/uDJQDHduBvx2hJce6056PznsiDtz0J27dN2zP6vba+fJ6FViEqYLpv5r1jM/tUGR+0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AJBkt4XT; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744829437; x=1776365437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A+Fa6tCcKDP0isuni/bFBzZNWGVbTE6optXqhxcf4zk=;
  b=AJBkt4XTZ9wnX2b0f0dwo0s3UyUhmnT75jXjPHtqAVkJn+Srm2MXFc8q
   aTNHOisR87wfLmJzdzrxaAtj1ltzpXYLJFS7yzfA09NvO6TZ6+1tZ27i3
   uIVihGTQBRluLskThY9lLVSEOj2C9uPs4iOiPz8ah4XfawmB1f8sFdP0M
   s=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="512114214"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:50:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.169:2525] with esmtp (Farcaster)
 id 7264ab5c-87a0-41cb-a25f-b3fbbef55f54; Wed, 16 Apr 2025 18:50:29 +0000 (UTC)
X-Farcaster-Flow-ID: 7264ab5c-87a0-41cb-a25f-b3fbbef55f54
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:50:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:50:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 06/14] ipv6: Split ip6_route_info_create().
Date: Wed, 16 Apr 2025 11:50:08 -0700
Message-ID: <20250416185017.588-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <9903a135-1f30-4a76-9c14-36159eb413d6@redhat.com>
References: <9903a135-1f30-4a76-9c14-36159eb413d6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 11:12:31 +0200
> On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> > We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT and rely
> > on RCU to guarantee dev and nexthop lifetime.
> > 
> > Then, we want to allocate everything as possible before entering
> 
> Then, we want to allocate everything before ...
> 
> or
> 
> Then, we want to allocate as much as possible before ...

Will use the latter, thanks!

