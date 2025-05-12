Return-Path: <netdev+bounces-189901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC72AB4734
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E2119E412F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD529712E;
	Mon, 12 May 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cZAZxMTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A9134D4
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088427; cv=none; b=U0IJnFJ1fQJLRIYV5JNko4eg8m2KlfCzA9sFIvEx3CaeSA7YXlsUrzfJYCNqrWfP9qHtcOIehrQgJTebLyhv8WCG0mDW7UkaD4wVdsMW1JiNl8564mLmQhk7F50kQPit7WmFVYlP3+oecGK6wmwFwLHZavUvGChPMwhDc9tgRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088427; c=relaxed/simple;
	bh=wV+mKG5buZ62iMDSg2eJKOxqyFD38bn8rL4/GlMf88c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIjiwNnF0hGNREwb+M0KhU9pfAKC/5JgPRZtKqygDAdsdsKruoQtRCusgM7L+dDzrfEVbgINB7U/8cn2j/6OaeL08dNsbkk6/ta2mmrQVGqd/Dv80dDhmIApao/pkFeEoMTAEuwdf5F7SWLu1DoifcUe6BJwxTSL9OXcp4hTaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cZAZxMTv; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747088426; x=1778624426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=byoqVaKnE/Uhdxgj/jcJFpbB3rZ5caQkxSL19gzfgck=;
  b=cZAZxMTvZAKCdkgN3egkPQaqkAsWeWc/WCfFCJu0LtP2RVtDcCovByL+
   0C06qlXO+fA0KK++wwW6KNZxIllyoYS4HrGr49NdTMYk+ogTpxyb2mIA+
   iJ/HjVPHJku2PAVghBmtrrMC2PYb/qdjcSajr1jPJ8FNO9uH1vNb43bh6
   T2/K+DnqZqNHkTXeJO22phPTX4+rymmyySVv7uvtIjtF3dMmnRMpQpSKi
   5BdbWdZuF6KJEDKFbw4hT2tZhJppgXA/hSPKAZm5tm5QiSUQzK0XWIUPI
   hov1OVqdUBbNu4XGv88YKmimA514WKyOq3RaucmwTsnbKuJhVSPa8VixA
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,283,1739836800"; 
   d="scan'208";a="722025189"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 22:20:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:16066]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.111:2525] with esmtp (Farcaster)
 id 0c9d1382-0b13-42d0-be58-beebb8993625; Mon, 12 May 2025 22:20:22 +0000 (UTC)
X-Farcaster-Flow-ID: 0c9d1382-0b13-42d0-be58-beebb8993625
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:20:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:20:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
Date: Mon, 12 May 2025 15:20:09 -0700
Message-ID: <20250512222011.57059-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68224a16ebe11_e985e29446@willemb.c.googlers.com.notmuch>
References: <68224a16ebe11_e985e29446@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 12 May 2025 15:20:54 -0400
> Kuniyuki Iwashima wrote:
> > As explained in the next patch, SO_PASSRIGHTS would have a problem
> > if we assigned a corresponding bit to socket->flags, so it must be
> > managed in struct sock.
> > 
> > Mixing socket->flags and sk->sk_flags for similar options will look
> > confusing, and sk->sk_flags does not have enough space on 32bit system.
> > 
> > Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> > SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> > is known to be slow, and managing the flags in struct socket cannot
> > avoid that for embryo sockets.
> > 
> > Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> > 
> > While at it, other SOCK_XXX flags in net.h are grouped as enum.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 1ab59efbafc5..9540cbe3d83e 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1224,19 +1224,19 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> >  		if (!sk_may_scm_recv(sk))
> >  			return -EOPNOTSUPP;
> >  
> > -		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
> > +		sk->sk_scm_security = valbool;
> 
> Is it safe to switch from atomic to non-atomic updates?
> 
> Reads and writes can race. Especially given that these are bit stores, so RMW.

Exactly, will move them down after sockopt_lock_sock().

