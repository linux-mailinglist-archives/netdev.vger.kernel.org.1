Return-Path: <netdev+bounces-189966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1FAB4A0E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6986161D7A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45219D8B2;
	Tue, 13 May 2025 03:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PqJhjdJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BE45038
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106337; cv=none; b=gFAcNRuLc43aCAkgb5512uUZ1X2e9hL74rq2gde5sEevGwlgbYMIgcuRJh7Kwsj06s7ttXXBBpC+BbYFv4ztxUQXT5n0KODo0UUKtRYkNMle3IcaoHjFDWGBdb7QUebjNeipkEFKVJb9Js3agVD3dqTLFHz6BikIu1q0cxnXC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106337; c=relaxed/simple;
	bh=ngcTZmwuTpYt+afr5TOO2ql78gDtQQ4ZYeQO8nrQHh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+97WD/1eWqwg8puaJ7669uwyViVPWN28MCtJi7UyYDDqCw3F41WsVapEc+mZAAw3h74FD39pARX614IGAyoGPFB3/fJvSOHDm3gtz6KMYaZFtRbZFFBalJe/K8nNK75gH2wUpG6C51QjqCj2NaiG7fcgvTVN7mpXk6wYRBAq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PqJhjdJK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747106335; x=1778642335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+IbNdIus8KBxIR04Q1LibNAdqHvjFUlAdV7CStIj08=;
  b=PqJhjdJKwuDmyeZ0eqA9hZHhzkXdiO14gVNnz6ZMAnM/6dPf+EZmQLDt
   dn+wfkynmNe9FG6WJqz6Kr53etUpCrkuA+fOmI0/g5OJCHBV281yifwBV
   M6ipS758pLoapB52nSKNMQvohpGxBMmEHJ8YJiHUsmjSgZgie3TDPyypV
   WTQimRlUn2ciQFWkX0KcE+1UdwQHK8YWWQkHFro15CgrLUkJ8drNhCwNK
   OOAvPdrm8cmY+HyGyHdDTY069aBVCHsEEVBdYZryRXigKZZ1kLbmWd5gJ
   /LcGcTGJu/71Y3BWrtgTz0zGHozCLM4faWfNCJ7MseTqfBq4cyZ7LOJ+t
   g==;
X-IronPort-AV: E=Sophos;i="6.15,284,1739836800"; 
   d="scan'208";a="491556904"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:18:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:32150]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.4:2525] with esmtp (Farcaster)
 id b732235d-f6d0-40a2-ba6f-48a80328919f; Tue, 13 May 2025 03:18:48 +0000 (UTC)
X-Farcaster-Flow-ID: b732235d-f6d0-40a2-ba6f-48a80328919f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 03:18:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 03:18:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
Date: Mon, 12 May 2025 20:18:15 -0700
Message-ID: <20250513031837.95186-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6822b1f41c3c0_104f1029470@willemb.c.googlers.com.notmuch>
References: <6822b1f41c3c0_104f1029470@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 12 May 2025 22:44:04 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Mon, 12 May 2025 15:20:54 -0400
> > > Kuniyuki Iwashima wrote:
> > > > As explained in the next patch, SO_PASSRIGHTS would have a problem
> > > > if we assigned a corresponding bit to socket->flags, so it must be
> > > > managed in struct sock.
> > > > 
> > > > Mixing socket->flags and sk->sk_flags for similar options will look
> > > > confusing, and sk->sk_flags does not have enough space on 32bit system.
> > > > 
> > > > Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> > > > SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> > > > is known to be slow, and managing the flags in struct socket cannot
> > > > avoid that for embryo sockets.
> > > > 
> > > > Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> > > > 
> > > > While at it, other SOCK_XXX flags in net.h are grouped as enum.
> > > > 
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > 
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index 1ab59efbafc5..9540cbe3d83e 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -1224,19 +1224,19 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> > > >  		if (!sk_may_scm_recv(sk))
> > > >  			return -EOPNOTSUPP;
> > > >  
> > > > -		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
> > > > +		sk->sk_scm_security = valbool;
> > > 
> > > Is it safe to switch from atomic to non-atomic updates?
> > > 
> > > Reads and writes can race. Especially given that these are bit stores, so RMW.
> > 
> > Exactly, will move them down after sockopt_lock_sock().
> 
> So all reads in the datapath are with the socket locked? Okay, that
> was not immediately obvious to me. If respinning, please add a
> comment.

Sure, will add a comment.

