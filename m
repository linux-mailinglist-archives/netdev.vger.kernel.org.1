Return-Path: <netdev+bounces-150592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BD9EAD2F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01601188D98C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F764215780;
	Tue, 10 Dec 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZUaTtMWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70967215775
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824047; cv=none; b=I1+23uRylZlSMvNTjVwkMocAymV/QBTCDtpds9ZCotasg6IvIT8avi37M/74p4s+cmSEBvzC0lOhcNiq6/HLmbJ9HXKaiU13g3Do6dXCSogiiqfJutT6UtNyxRnpzVsHwxxGW73WbiKoGJkW6mvgoJOzVEOcj29gEWyhJHEWBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824047; c=relaxed/simple;
	bh=Yq/g1+dlm+VkcybN+h2Y8RtQ/vZYo7MXe09kKqZaMjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI953bIYOqYKOjdT3WTh629wOMZSQUpQTnYzs3RqQpi46p9akXXrBNYb7cX4XUZUXIBYJr5OfdcUKEGHuw+dwiLUSVCtggXxLAvqiZiJMDHC1P1jaD7G9a05gFodr3U8ftjeptfgQJADP9PXXm1PjNy/FQFn1tQMD8Uq/X7FngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZUaTtMWE; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733824046; x=1765360046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+nQk20/RHfQJBAfdTJfM7QSr5cTW54e3CPpW+j3xuRc=;
  b=ZUaTtMWEkJCn3SNvX+iUKcqoQs0FilGcC25qdUpbmXtZBTmeV2/WbrTj
   a05V04rsd7H9bspNBiv1XdVv+KNiEby6hJ+EGyyiIGxO9cTeilAkE4BWE
   F/81YOuFa/GsfkpmyCpZNTN9KoOGVX++gvFcIpEsjrwPvdxROfQ2ZAtk1
   k=;
X-IronPort-AV: E=Sophos;i="6.12,222,1728950400"; 
   d="scan'208";a="359438288"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 09:47:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:9157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.104:2525] with esmtp (Farcaster)
 id 9250ef6a-cffe-4683-b2b6-dc88e0d0fbe5; Tue, 10 Dec 2024 09:47:23 +0000 (UTC)
X-Farcaster-Flow-ID: 9250ef6a-cffe-4683-b2b6-dc88e0d0fbe5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 09:47:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 09:47:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 00/15] treewide: socket: Clean up sock_create() and friends.
Date: Tue, 10 Dec 2024 18:47:16 +0900
Message-ID: <20241210094716.76970-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iKHE=ucDztegP5TPHM=6e0JaGApQ7J==4r1Q9nffm+-sQ@mail.gmail.com>
References: <CANn89iKHE=ucDztegP5TPHM=6e0JaGApQ7J==4r1Q9nffm+-sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 09:46:27 +0100
> On Tue, Dec 10, 2024 at 8:38 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > There are a bunch of weird usages of sock_create() and friends due
> > to poor documentation.
> >
> >   1) some subsystems use __sock_create(), but all of them can be
> >      replaced with sock_create_kern()
> >
> >   2) some subsystems use sock_create(), but most of the sockets are
> >      not tied to userspace processes nor exposed via file descriptors
> >      but are (most likely unintentionally) exposed to some BPF hooks
> >      (infiniband, ISDN, NVMe over TCP, iscsi, Xen PV call, ocfs2, smbd)
> >
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
> > Finally, we rename sock_create() and sock_create_kern() to
> > sock_create_user() and sock_create_net_noref(), respectively.
> > This intentionally breaks out-of-tree drivers to give the owners
> > a chance to choose an appropriate API.
> >
> > Throughout the series, we follow the definition below:
> >
> >   userspace socket:
> >     * created by sock_create_user()
> >     * holds the reference count of the network namespace
> >     * directly linked to a file descriptor
> >       * currently all sockets created by sane sock_create() users
> >         are tied to userspace process and exposed via file descriptors
> >     * accessed via a file descriptor (and some BPF hooks except
> >       for BPF LSM)
> >     * counted in the first line of /proc/net/sockstat.
> >
> >   kernel socket
> >     * created by sock_create_net() or sock_create_net_noref()
> >       * the former holds the refcnt of netns, but the latter doesn't
> >     * not directly exposed to userspace via a file descriptor nor BPF
> >       except for BPF LSM
> >
> > Note that __sock_create(kern=1) skips some LSMs (SELinux, AppArmor)
> > but not all; BPF LSM can enforce security regardless of the argument.
> >
> > I didn't CC maintainers for mechanical changes as the CC list explodes.
> >
> >
> > Changes:
> >   v2:
> >     * Patch 8
> >       * Fix build error for PF_IUCV
> >     * Patch 12
> >       * Collect Acked-by from MPTCP/RDS maintainers
> >
> >   v1: https://lore.kernel.org/netdev/20241206075504.24153-1-kuniyu@amazon.com/
> >
> 
> My concern with this huge refactoring is the future backports hassle,
> before going to the review part...

I understand that concern as a distributor, that's why I waited the
sunrpc fix to be merged into net-next, which I believe is the last
problematic caller of sock_create_kern(AF_INET6?, SOCK_STREAM).

Also, I think socket()/accept()/sk_alloc() are unlikely to have
many bugs and get updated so frequently.

  $ git log --oneline v5.4.286...v5.4 -- net/socket.c | wc -l
  13
  $ git log --oneline v5.10.230...v5.10 -- net/socket.c | wc -l
  13
  $ git log --oneline v5.15.173...v5.15 -- net/socket.c | wc -l
  8
  $ git log --oneline v6.1.119...v6.1 -- net/socket.c | wc -l
  13

b7d22a79ff4e ("net: explicitly clear the sk pointer, when pf->create
fails") is the only patch touching sock_create(). (in 5.15+)

Recently, I backported ef7134c7fc48 ("smb: client: Fix use-after-free
of network namespace.") to our 5.4/5.10/5.15/6.1 trees (and will post
them to upstream stable trees) and it didn't have conflicts in terms
of networking code.


> 
> Also the change about counting or not 'kernel sockets' in
> /proc/net/sockstat is orthogonal.

I dug a bit more history.

/proc/net/sockstat was initially a global counter and later
it's namespacified by 648845ab7e200 in 2017.

Before the commit, the global counter included all sockets.

But 26abe14379f8 changed kernel sockets not to hold netns
refcount in 2015, so we can't decrement the namespacified
counter during socket destruction for kernel sockets.

Then, the namespacified sockstat was changed to include sockets
holding netns refcnt, and it was only userspace sockets until the
first kernel socket conversion.

So, the option would be either of

  1) keep as is (counting userspace sockets and kernel sockets
     with net refcnt)

  2) count userspace sockets only

  3) count all sockets (and detect callers of sock_create_kern()
     who touches kernel sockets after netns is freed, with help
     of syzbot and KMSAN/KASAN)

3) is invasive but seems doable considering now we have
ref_tracker_dir_exit() for kernel sockets in net_free().

What do you think ?

