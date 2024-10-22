Return-Path: <netdev+bounces-138004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25239AB711
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D16A284961
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E411C9EC7;
	Tue, 22 Oct 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nJerMDSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A871A2547
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626132; cv=none; b=oqbCFIxSdJMWRAT08aLN2jRJcYN4On428+nQ/F8cDuzKXdauC6nkj2xZP3J3jPAN0vUlDI3TsDEhESulQHePlZTyUpb4RHUHByfhTWgIU3AxwTqWQ0dmqMORAwTqK6xGilvE+4WcJpY1uhBKs8FmqclrN5+Npqrf0xpCtP3iyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626132; c=relaxed/simple;
	bh=8u2z9OcF3av1yAbmJfe0ka+WnSg+hzQarvChT9pKBVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBGEgE5LhqPd7AR5jyB2LdEyAt87olZLPQKB0eQTJV4yeoLcL+T4ACdioykCo5SsuHX4Z+HCy8i4I7eKdexvYd7fx6Wt8nz8IsLv9gjPCo6enTTj+bLMxKFs6wX5+OBzVXUx5Xm79FE81vupErhDFwEp+lrLeAU8TxL2GbeApuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nJerMDSQ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729626132; x=1761162132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMXoWxWRs4qEIHgmI6235Rrtz3CT9SJfdegNc74reSo=;
  b=nJerMDSQVTLSTSBdAKgh5xqvM6B/LCeW7bB5iImebduImUApiuqmxrz3
   tUFijbV2UOaL3mnpCBcOWnLIssuiToLV8WVYoONRj3vgcySqes+sZQRGk
   3DZy0XBLYG1gRJ/LU/ltseQFDFB/RvundZm8zLLuBmj+0jRLbZuHc6s9R
   8=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="668341557"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:42:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:19602]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.247:2525] with esmtp (Farcaster)
 id b7f1c655-edbf-40a4-beb8-f165c12a674e; Tue, 22 Oct 2024 19:42:07 +0000 (UTC)
X-Farcaster-Flow-ID: b7f1c655-edbf-40a4-beb8-f165c12a674e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 19:42:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 22 Oct 2024 19:42:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<jk@codeconstruct.com.au>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <matt@codeconstruct.com.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <razor@blackwall.org>, <roopa@nvidia.com>
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: Return int from rtnl_af_register().
Date: Tue, 22 Oct 2024 12:42:01 -0700
Message-ID: <20241022194201.70485-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241022085920.GS402847@kernel.org>
References: <20241022085920.GS402847@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Tue, 22 Oct 2024 09:59:20 +0100
> On Tue, Oct 22, 2024 at 10:53:32AM +0200, Paolo Abeni wrote:
> > On 10/16/24 20:53, Kuniyuki Iwashima wrote:
> > > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > > index 445e6ffed75e..70b663aca209 100644
> > > --- a/net/core/rtnetlink.c
> > > +++ b/net/core/rtnetlink.c
> > > @@ -686,11 +686,13 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
> > >   *
> > >   * Returns 0 on success or a negative error code.
> > >   */
> > > -void rtnl_af_register(struct rtnl_af_ops *ops)
> > > +int rtnl_af_register(struct rtnl_af_ops *ops)
> > >  {
> > >  	rtnl_lock();
> > >  	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
> > >  	rtnl_unlock();
> > > +
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(rtnl_af_register);
> > 
> > kdoc complains about the missing description for the return value. You
> > need to replace 'Returns' with '@return'.
> > 
> > Not blocking, but please follow-up.
> 
> FWIIW, I think "Return: " or "Returns: " also works.

Sure, will post a followup shortly.

Thanks!

