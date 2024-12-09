Return-Path: <netdev+bounces-150031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14D9E8AF7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893A1280E9B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12914D717;
	Mon,  9 Dec 2024 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j9B4iLnP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1E54918
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733722017; cv=none; b=FQ990+WMQ0XcDLULJ9KYx4wuj2ohWy5T9jwA033Nkt8df/cRxNcC+hTakAB4ElTaT+4fFDaStxy1WKYUQJhDfBX7qXFSrN4oVvuBUiIPQmqZPH7a8JMfuaHxRctYJ2hrFDPBXk6eT8g1hNipOxABKTpSf+Q80dsY7wQrxPzHs5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733722017; c=relaxed/simple;
	bh=rDPs66ls2Ar2HWx8s9z4l6bULwJUOopY1Mg/SJLyxlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ED+g7t665ibkuSwsgkJHSzv63/bcBuoLXm0v1oBm+1patun8BusJm7PRezdeByKEmkduiqLApUJT98Kitv+TndMwGPXc9dOOy9IEjj6XisEynDyqaBwY6sqDlf+mBkxQ1ElrkCay/8VfIMdAaJ1K1fyExtg/iWBkZkxfwJ+KlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j9B4iLnP; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733722016; x=1765258016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PrUpfO15SvHBigZbpgC9HlFdlkqgwCXpcBpiu7xM0YE=;
  b=j9B4iLnPMctLZMmw3CaocXsd6wbGYm4c/S3A6gT0p6JMG9H3cO+w7Ena
   bgyDVgDxIj92c1oUk3/tU0nKbZH7k7E6Rk+QSLhRhmFkqUeDUc+x6fu8V
   ENCFSlYdiFGb4/MlTnnlqfwWk5gIpKzf1a5JGZWP6yWRAgi9XZuU9v5jF
   o=;
X-IronPort-AV: E=Sophos;i="6.12,218,1728950400"; 
   d="scan'208";a="454378766"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:26:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:55345]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.104:2525] with esmtp (Farcaster)
 id 966092e1-e2b7-46e9-aa16-0f29ad0c137f; Mon, 9 Dec 2024 05:26:51 +0000 (UTC)
X-Farcaster-Flow-ID: 966092e1-e2b7-46e9-aa16-0f29ad0c137f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Dec 2024 05:26:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.254.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 9 Dec 2024 05:26:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.laight@aculab.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 00/15] treewide: socket: Clean up sock_create() and friends.
Date: Mon, 9 Dec 2024 14:26:43 +0900
Message-ID: <20241209052643.9896-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <85ad278ad61943938a6537f1405f7814@AcuMS.aculab.com>
References: <85ad278ad61943938a6537f1405f7814@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Laight <David.Laight@ACULAB.COM>
Date: Sun, 8 Dec 2024 10:54:23 +0000
> From: Kuniyuki Iwashima
> > Sent: 06 December 2024 07:55
> > 
> > There are a bunch of weird usages of sock_create() and friends due
> > to poor documentation.
> > 
> >   1) some subsystems use __sock_create(), but all of them can be
> >      replaced with sock_create_kern()
> 
> Not currently because sock_create_kern() doesn't increase the ref count
> on the network namespace.
> So I have an out of tree driver that end up using __sock_create() in
> order that the socket holds a reference to the network namespace.

An out of tree driver is apparently out of scope, and the owner always
needs to follow the upstream change.

That's one of reasons I changed the arguments and renamed sock_create()
helpers, letting the out-of-tree drivers notice the change through build
failure.


> 
> >   2) some subsystems use sock_create(), but most of the sockets are
> >      not exposed to userspace via file descriptors but are exposed
> >      to some BPF hooks (most likely unintentionally)
> 
> AFAIR the 'kern' flag removes some security/permission checks.

Right.


> So a socket that is being created to handle user API requests
> (user data might be encapsulated and then sent) probably ought
> to have 'kern == 0' even though the socket is not directly exposed
> through the fd table.

tun/tap is counterexample, where sk_alloc(kern=0) is directly
used instead of sock_create(), then no LSM is invoked.


> 
> >   3) some subsystems use sock_create_kern() and convert the sockets
> >      to hold netns refcnt (cifs, mptcp, rds, smc, and sunrpc)
> > 
> >   4) the sockets of 2) and 3) are counted in /proc/net/sockstat even
> >      though they are untouchable from userspace
> > 
> > The primary goal is to sort out such confusion and provide enough
> > documentation for future developers to choose an appropriate API.
> > 
> > Regarding 3), we introduce a new API, sock_create_net(), that holds
> > a netns refcnt for kernel socket to remove the socket conversion to
> > avoid use-after-free triggered by TCP kernel socket after commit
> > 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns
> > of kernel sockets.").
> > 
> > Throughout the series, we follow the definition below:
> > 
> >   userspace socket:
> >     * created by sock_create_user()
> >     * holds the reference count of the network namespace
> >     * directly linked to a file descriptor
> >     * accessed via a file descriptor (and some BPF hooks)
> >     * counted in the first line of /proc/net/sockstat.
> > 
> >   kernel socket
> >     * created by sock_create_net() or sock_create_net_noref()
> >       * the former holds the refcnt of netns, but the latter doesn't
> >     * not directly exposed to userspace via a file descriptor nor BPF
> 
> That isn't really right:
> A 'userspace socket' (kern == 0) is a socket created to support a user's
> API calls. Typically (but not always) directly linked to a file descriptor.
> Security/permission checks include those of the current user/process.
> 
> A 'kernel socket' (kern == 1) is a socket that isn't related to a user process.
> These fall into two groups:
> 1) Normal TCP (etc) sockets used by things like remote filesystems.
>    These need to hold a reference to the network namespace and will stop
>    the namespace being deleted.

You'll see all of the sockets using sock_create() in the patch below
are of this type.  (infiniband, ISDN, NVMe over TCP, iscsi, Xen PV call,
ocfs2, smbd)
https://lore.kernel.org/netdev/20241206075504.24153-14-kuniyu@amazon.com/

Only one valid user of sock_create() is SCTP, and it's "created to support
users's API call" and actually tied to a file descriptor.
https://lore.kernel.org/netdev/20241206075504.24153-15-kuniyu@amazon.com/

From this POV, I think tun/tap also should use kern=true && hold_net=true.
No 'socket' is mentioned in tun/tap doc.  Users need not be aware of the
underlying sockets.

  $ grep socket Documentation/networking/tuntap.rst
  $ echo $?
  1

> 2) Special sockets used internally (perhaps for routing).
>    These don't hold a reference, but require the caller have a callback
>    for the namespace being deleted and must close the socket before
>    the callback returns.
>    The close must be fully synchronous - FIN_WAIT states will break things.
> 
> > Note that I didn't CC maintainers for mechanical changes as the CC
> > list explodes.
> 
> This whole change (which is probably worth it) need doing in a different
> order.

I don't think it's worth it, and you are inconsistent.

This series is a revival of my old patch, where I tried to
override the kern parameter.

Interestingly, you suggested adding another parameter then,
that was opposite of what you are suggesting now.
https://lore.kernel.org/netdev/20240227011041.97375-4-kuniyu@amazon.com/


> Start with the actual change to the socket create code and then work
> back through the callers.
> That may require adding wrapper functions for the existing calls that
> can then finally be deleted in the last patch.
> 
> Additionally boolean parameters need to be banned, multiple ones
> are worse - you really can tell from the call site what they mean.

As mentioned above, this is intentional to break out-of-tree drivers
and give the owners a chance to look at this change.

For example, we provide Lustre service with an out-of-tree driver
where sock_crete_kern() is used and needs update along future kernel
update.

Also, changing param let compilers inspect all sock_create_XXX()
users, and there was a weird path like smc_ulp_init().
https://lore.kernel.org/netdev/20241206075504.24153-4-kuniyu@amazon.com/


> 
> So change the boolean 'kern' parameter to a flags one.
> You then want 0 to be the normal case (user socket that holds a ref).
> Then add (say):
> 	#define SOCK_CREATE_NO_NS_REF 1
> 	#define SOCK_CREATE_KERN      2
> Initially add to the top of sk_alloc():
> 	if (flags & SOCK_CREATE_NOREF)
> 		flags |= SOCK_CREATE_KERN;
> Now all the code compiles and works as before.
> 
> Next find all the call sites (especially those that pass 1)
> and change so they pass the correct flag combination.

Changing param allows us to effectively inspect these callers with
help of the compiler.


> (Some static inlines/#defines might help with long lines.)
> 
> Finally change sk_alloc() to return NULL if NO_NS_REF
> is set without KERN.

This is no-go, no one wants to debug a weird -ENOMEM.

I added DEBUG_NET_WARN_ON_ONCE() for such a case so that
syzbot will let us know that pattern
https://lore.kernel.org/netdev/20241206075504.24153-10-kuniyu@amazon.com/

