Return-Path: <netdev+bounces-71812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDF68552E3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF801C219AC
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6233127B43;
	Wed, 14 Feb 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O5snQKzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10360DE5
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937634; cv=none; b=p06b8OMyy7vzthQxG29T4yPcTDzHXwv6QIZOLIC3G/LvhX3f/gY0SNGp5gS7zTVeV0wO6RF+4iQ21ro8KPCm7FXIiQNMOimTXB7ua9PY00wH6F88nz1XcbbPMvxXPSm+9UOfovDbDn2wogOWYnePRxY6P9nK1rU2QdL8bU0U8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937634; c=relaxed/simple;
	bh=BHFgCtpclEkwS/I7RWydnActKHW1N5IGLz6F625wrvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbsQtnvqs1qhCMnZRLd8BRE7ySUMKjSSwsMj4NQJ2Ol8qRmBTrcuxRFC05eSCh2alD1EzBopwqEv1i9ktMFAww1BW9Jo0PX4Jy3ptNiuYWJCyx4IffHs+GT/asAvMzNtBExlQC7aX69RSNVJHdinXDpRHQSjBlRzpP6QqOdN5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=O5snQKzY; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707937633; x=1739473633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2219ad+OX3v69tWx4ihj4Gciz8R6W/BmTJIc2uh5YeA=;
  b=O5snQKzYxbHSUFI6eogv7crpoOcuP8SdhiXDF70LCqOE3jDiwdFg1MlR
   xprj7qxspGWutqRU7vbIt1K4fENoHddnD3r3UtvwMzSN6IEjee6Uk8UEq
   Sw8t/wQ+EkiAQxmtZAWTkyVxUy6ecNsYlVwpyQB5xEOzH2gRjB0nKx6P9
   o=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705363200"; 
   d="scan'208";a="274164855"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:07:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:15553]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id 17deda40-9dae-43ca-921f-0fc326ba78f9; Wed, 14 Feb 2024 19:07:11 +0000 (UTC)
X-Farcaster-Flow-ID: 17deda40-9dae-43ca-921f-0fc326ba78f9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:07:11 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 19:07:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<joannelkoong@gmail.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net] dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
Date: Wed, 14 Feb 2024 11:07:01 -0800
Message-ID: <20240214190701.97643-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240214185649.96945-1-kuniyu@amazon.com>
References: <20240214185649.96945-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 14 Feb 2024 10:56:49 -0800
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 14 Feb 2024 10:05:33 +0100
> > On Tue, Feb 13, 2024 at 10:42 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > >
> > > syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
> > > repro.
> > >
> > >   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
> > >
> > > However, the syzkaller's log hinted that connect() failed just before
> > > the warning due to FAULT_INJECTION.  [1]
> > >
> > > When connect() is called for an unbound socket, we search for an
> > > available ephemeral port.  If a bhash bucket exists for the port, we
> > > call __inet_check_established() or __inet6_check_established() to check
> > > if the bucket is reusable.
> > >
> > > If reusable, we add the socket into ehash and set inet_sk(sk)->inet_num.
> > >
> > > Later, we look up the corresponding bhash2 bucket and try to allocate
> > > it if it does not exist.
> > >
> > > Although it rarely occurs in real use, if the allocation fails, we must
> > > revert the changes by check_established().  Otherwise, an unconnected
> > > socket could illegally occupy an ehash entry.
> > >
> > > Note that we do not put tw back into ehash because sk might have
> > > already responded to a packet for tw and it would be better to free
> > > tw earlier under such memory presure.
> > >
> > > [0]:
> > >
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > > v2:
> > >   * Unhash twsk from bhash/bhash2
> > >
> > > v1: https://lore.kernel.org/netdev/20240209025409.27235-1-kuniyu@amazon.com/
> > > ---
> > >  net/ipv4/inet_hashtables.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > > index 93e9193df544..b22c71f93297 100644
> > > --- a/net/ipv4/inet_hashtables.c
> > > +++ b/net/ipv4/inet_hashtables.c
> > > @@ -1130,10 +1130,31 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
> > >         return 0;
> > >
> > >  error:
> > > +       if (sk_hashed(sk)) {
> > > +               spinlock_t *lock = inet_ehash_lockp(hinfo, sk->sk_hash);
> > > +
> > > +               sock_prot_inuse_add(net, sk->sk_prot, -1);
> > > +
> > > +               spin_lock(lock);
> > > +               sk_nulls_del_node_init_rcu(sk);
> > > +               spin_unlock(lock);
> > > +
> > > +               sk->sk_hash = 0;
> > > +               inet_sk(sk)->inet_sport = 0;
> > > +               inet_sk(sk)->inet_num = 0;
> > > +
> > > +               if (tw)
> > > +                       inet_twsk_bind_unhash(tw, hinfo);
> > > +       }
> > > +
> > >         spin_unlock(&head2->lock);
> > >         if (tb_created)
> > >                 inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
> > >         spin_unlock_bh(&head->lock);
> > > +
> > > +       if (tw)
> > > +               inet_twsk_deschedule_put(tw);
> > 
> > Please make sure to call this while BH is still disabled.
> > 
> > 
> >     spin_unlock(&head->lock);
> >     if (tw)
> >         inet_twsk_deschedule_put(tw);
> >    local_bh_enable();
> 
> Sure, will update in v3 and post a followup for the existing
> inet_twsk_deschedule_put() to net-next later.

The existing one was doing that, it seems somehow I copied the
different code elsewhere ... :p

