Return-Path: <netdev+bounces-134349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C682B998E67
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1201F248E9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ABD19ABCE;
	Thu, 10 Oct 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RHvfiVq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355C199FCE
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581826; cv=none; b=F5z20LdoSEzggRqXPVhWrdLNb9p9UdpSeEgvKBFCeR62bkcPbjc0MsQum2AK4+NuSZS7XTU9ynk57x+UgRCAQZlyUSIR+rDq2ZK7mdjvnXubk5+pLhzZYhhoW8n+MGNGVpjYUade4uxE/KB9YCmuyK1EUrfzEfgoy6wMqBj6zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581826; c=relaxed/simple;
	bh=tZUGTQHkfITDbhgpcKpNAz3dwctqhj2m0uJK7gfQD/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlGB1ZoZmb2n51oydCLFg3W8GsmLbvqIzp7RG27NHgEMFsCQ2+oUdxF96Ke3Ne71o51hGwLdiY+9U5jEOefgtul+7lvvG5DRgMFfdcyGuKq5KdqSX0KN2WM9XJfDnlVbdHhqNP7pa1oMK9nx5ZoJEMyW+ZBuezlsH48Pdr1IwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RHvfiVq+; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728581822; x=1760117822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pybfBtJFKcw+F5bQ4KSVuTbkhJhRgiX7GOpjqA8UpLA=;
  b=RHvfiVq+ku0cYToP7RuxwCmuEUI3M8xozz8nhOBay2r7FXpxWvMPnrA5
   ke/YBDwJJi9gmwyH8da3gf4JCyCJJ7HzMH/XhJ04dCxceEEsBrbU/M0qF
   /FAvfGuO/KMLL4iOsA/itQbck99b8RQOzE3PNMan1Dk/mYzPY5IQOHjnf
   U=;
X-IronPort-AV: E=Sophos;i="6.11,193,1725321600"; 
   d="scan'208";a="439870326"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:36:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:26932]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 7fd77931-2389-46d1-8efc-4c97461ca732; Thu, 10 Oct 2024 17:36:57 +0000 (UTC)
X-Farcaster-Flow-ID: 7fd77931-2389-46d1-8efc-4c97461ca732
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 17:36:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.88.181.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 17:36:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Thu, 10 Oct 2024 10:36:51 -0700
Message-ID: <20241010173651.68780-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <a1ecbca9-52c8-4653-a404-961b8e4fc674@linux.dev>
References: <a1ecbca9-52c8-4653-a404-961b8e4fc674@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Wed, 9 Oct 2024 22:46:57 -0700
> On 10/9/24 10:42 AM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index 2c5632d4fddb..23cff5278a64 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1045,12 +1045,13 @@ static bool reqsk_queue_unlink(struct request_sock *req)
> >   		found = __sk_nulls_del_node_init_rcu(sk);
> >   		spin_unlock(lock);
> >   	}
> > -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
> > -		reqsk_put(req);
> > +
> >   	return found;
> >   }
> >   
> > -bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
> > +static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
> > +					struct request_sock *req,
> > +					bool from_timer)
> >   {
> >   	bool unlinked = reqsk_queue_unlink(req);
> >   
> > @@ -1058,8 +1059,17 @@ bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
> >   		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> >   		reqsk_put(req);
> >   	}
> > +
> > +	if (!from_timer && timer_delete_sync(&req->rsk_timer))
> 
> timer_delete_sync() is now done after the above reqsk_queue_removed().
> The reqsk_timer_handler() may do the "req->num_timeout++" while the above 
> reqsk_queue_removed() needs to check for req->num_timeout. Would it race?

Ah thanks!
I moved it for better @unlinked access, but will move above.

Btw, do you have any hint why the connection was processed on a different
cpu, not one where reqsk timer was pinned ?

