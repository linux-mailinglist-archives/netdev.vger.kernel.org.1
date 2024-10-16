Return-Path: <netdev+bounces-136340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606409A15FF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B6D1F23AE2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D81D517A;
	Wed, 16 Oct 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PQx5mAaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8841D5156
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120331; cv=none; b=fnt6w0T7j0nJ3O5D4ZrTY2ObRkDT3SsVrCLVPHeFunUSC0SibvSS/wqN3v0pl8rNbgISiWbMOFJ9q/kPPznwj2l1ftSZu2lobsNA1uewJobaGK8URh5K7gYDFeHEm+dvI3qTq8fGMjxErlPqOXIR7pjw+TWN6ANv0cmjBbzmp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120331; c=relaxed/simple;
	bh=tRNRzcc4Lh/auDCePqHVvoUS8wOWyN5bIqfDq4RcbZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOMW6QVJmINNyFynh60V+mAw515dK4PO+IjNYX96vTe3HLgYRyfXQztiGyrSNRzRnwo2VwPeDvQ87ZFCrQDPpbwq/N6OakiCqF3tg77fxCz3xRnevkfERJA/4+i2pfmcZ2wCgF1lI2KFaKvlfVMip5CprPl4GWA/1EMZOlh85NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PQx5mAaS; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729120330; x=1760656330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xlhvNOAgupP0YVsBNu0Akbj3wY8VKHvMzM9NyNj3Y8k=;
  b=PQx5mAaSLMIAVt2esWljBL5fpHdjYhDxmUD4Av/pr6SlLVp35Pvr5CS4
   uLrNR0j6Ydvype8GdAManvgUYL6B/Gj8Ice9HfBLMYNw+IG7kff+9gW9c
   TninRCkPj7aQl5CwYnuKzQ4hwSGeom2R/SauCuv1siBIp/U60TNB820x8
   o=;
X-IronPort-AV: E=Sophos;i="6.11,209,1725321600"; 
   d="scan'208";a="376851131"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:12:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:8970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id c0aa4f8c-731b-4fca-9f15-2ef198ec0df6; Wed, 16 Oct 2024 23:12:03 +0000 (UTC)
X-Farcaster-Flow-ID: c0aa4f8c-731b-4fca-9f15-2ef198ec0df6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 23:12:03 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 23:11:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dsahern@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jk@codeconstruct.com.au>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<matt@codeconstruct.com.au>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<razor@blackwall.org>, <roopa@nvidia.com>
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: Return int from rtnl_af_register().
Date: Wed, 16 Oct 2024 16:11:56 -0700
Message-ID: <20241016231156.25855-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <bcc229bb-d059-4184-9d82-c013566dc51d@kernel.org>
References: <bcc229bb-d059-4184-9d82-c013566dc51d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Ahern <dsahern@kernel.org>
Date: Wed, 16 Oct 2024 13:09:31 -0600
> On 10/16/24 12:53 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > index d81fff93d208..2152d8cfa2dc 100644
> > --- a/net/ipv4/devinet.c
> > +++ b/net/ipv4/devinet.c
> > @@ -2812,7 +2812,8 @@ void __init devinet_init(void)
> >  	register_pernet_subsys(&devinet_ops);
> >  	register_netdevice_notifier(&ip_netdev_notifier);
> >  
> > -	rtnl_af_register(&inet_af_ops);
> > +	if (rtnl_af_register(&inet_af_ops))
> > +		panic("Unable to register inet_af_ops\n");
> 
> why panic for IPv4 AF?

It's unlikely to fail to allocate memory for builtin during boot,
and I recently changed rtnl_register() to panic too, instead of
ignoring the errors.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=09aec57d8379

