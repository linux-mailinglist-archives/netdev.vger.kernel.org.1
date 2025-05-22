Return-Path: <netdev+bounces-192757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1838AC10EF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA74E16585C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356F227EAE;
	Thu, 22 May 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qnExXk3r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15917EED8
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931056; cv=none; b=Ju9GX0KDVKoiUtTJ85HZtXg9dpQwdGUxirt11B3hPZJe7iOexhocP5WYakeqq4yAkhDWLW7rwvBp4LciLBgnl5mb/yb83kbe8UHRhgI0e9LbkuCdu46Ot6uGZud7uYBcShEKsOuD0jy+lEx98rYqqWyFlSWjTbZY6MUqzDANWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931056; c=relaxed/simple;
	bh=8kgBLxLBGetOP6kq70679VXutIwGGB+0tIzlc1kA90Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQxW8FmLwaNgi/KzW05dZjEQdG+DZFvjYuIY4le2AHPPDWyQCDmylpaYznuIAF8jeMMho2yN02/2TLScFAgYx93OhEU3Iu2u9jHZwy4pZcpG/gMT1SBQ7FECC289nYR6K3K0qJxjFWgHgu4niE2O+kmOjivIEErqEk9Sr21Qr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qnExXk3r; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747931055; x=1779467055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8+TZ0zW80VT441EBWBjG5+Vo+PZ4p8eT9lH5CP517I=;
  b=qnExXk3r/5H/fGYc5+xEMwmR4Cq98PGLRjaM8E+ASG8pqGuu/BTxzTcl
   axo46hlZ+ovx/qqaSwaC+0iYfAE3pMhGUz87xqwzvp3PGG7YV0KsDLPyu
   BZxKBFuc6qJjwMBiSBtNiOR87r3q0OdOgQfW9GhSXnC3gKV6oDVWQqAkO
   WURqJ507xXj8dW66rpGXuYcbWotYIbmtJVTVyQVOIPIvB9d00RlgOcWTT
   El8pC+6A7hZIzksbNxYgiIZYhTe74sBnY1wDwhNvS6nhT6NJpniqkM46U
   M9ymsp03KW9AIW3cJ2d8SE8IcicS6Z+t9Tnr3rKCGKT91V4e042m1ulD5
   A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="495240878"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:24:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:53873]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.71:2525] with esmtp (Farcaster)
 id f77d07d9-4e69-4032-980a-38e8fdd6e401; Thu, 22 May 2025 16:24:11 +0000 (UTC)
X-Farcaster-Flow-ID: f77d07d9-4e69-4032-980a-38e8fdd6e401
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:24:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:24:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <matttbe@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net-next 3/6] socket: Restore sock_create_kern().
Date: Thu, 22 May 2025 09:23:55 -0700
Message-ID: <20250522162358.35076-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <a5654334-b0fc-419d-adbd-91eca9437e28@kernel.org>
References: <a5654334-b0fc-419d-adbd-91eca9437e28@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Matthieu Baerts <matttbe@kernel.org>
Date: Thu, 22 May 2025 17:02:45 +0200
> Hi Kuniyuki,
> 
> On 17/05/2025 05:50, Kuniyuki Iwashima wrote:
> > Let's restore sock_create_kern() that holds a netns reference.
> > 
> > Now, it's the same as the version before commit 26abe14379f8 ("net:
> > Modify sk_alloc to not reference count the netns of kernel sockets.").
> > 
> > Back then, after creating a socket in init_net, we used sk_change_net()
> > to drop the netns ref and switch to another netns, but now we can
> > simply use __sock_create_kern() instead.
> > 
> >   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> > 
> > DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> > from __net_init functions, since doing so would leak the netns as
> > __net_exit functions cannot run until the socket is removed.
> 
> Thank you for working on this!
> 
> (...)
> 
> > diff --git a/net/socket.c b/net/socket.c
> > index 7c4474c966c0..aeece4c4bb08 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1632,6 +1632,48 @@ int __sock_create_kern(struct net *net, int family, int type, int protocol, stru
> >  }
> >  EXPORT_SYMBOL(__sock_create_kern);
> >  
> > +/**
> > + * sock_create_kern - creates a socket for kernel space
> > + *
> > + * @net: net namespace
> > + * @family: protocol family (AF_INET, ...)
> > + * @type: communication type (SOCK_STREAM, ...)
> > + * @protocol: protocol (0, ...)
> > + * @res: new socket
> > + *
> > + * Creates a new socket and assigns it to @res.
> > + *
> > + * The socket is for kernel space and should not be exposed to
> > + * userspace via a file descriptor nor BPF hooks except for LSM
> > + * (see inet_create(), inet_release(), etc).
> > + *
> > + * The socket bypasses some LSMs that take care of @kern in
> > + * security_socket_create() and security_socket_post_create().
> > + *
> > + * The socket holds a reference count of @net so that the caller
> > + * does not need to care about @net's lifetime.
> > + *
> > + * This MUST NOT be called from the __net_init path and @net MUST
> > + * be alive as of calling sock_create_net().
> > + *
> > + * Context: Process context. This function internally uses GFP_KERNEL.
> > + * Return: 0 or an error.
> > + */
> > +int sock_create_kern(struct net *net, int family, int type, int protocol,
> > +		     struct socket **res)
> > +{
> > +	int ret;
> > +
> > +	DEBUG_NET_WARN_ON_ONCE(!net_initialized(net));
> > +
> > +	ret = __sock_create(net, family, type, protocol, res, 1);
> > +	if (!ret)
> 
> A small suggestion if you have to send a v2: when quickly reading the
> code, I find it easy to interpret the code above as: "in case of error
> with __sock_create(), the refcnt is upgraded" . It might be clearer to
> simply rename "ret" to "err" or use "(ret < 0)".
> 
> Up to you, a small detail for those who didn't directly realise what
> "ret" is :)

Makes sense, will use !err in v2 :)

