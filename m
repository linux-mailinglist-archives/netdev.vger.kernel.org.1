Return-Path: <netdev+bounces-71811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47328552CF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF8CB29906
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D012F5A2;
	Wed, 14 Feb 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vQDbnETd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB62134740
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937028; cv=none; b=rtrayyJMnfja7/yptUi0bUazeahQC+ohcX6UyiVPGVHMQdF2p0plAecJyZ95xec8pXPx47sZXRsCk4WSOuYFlQaLpyNpsFh1JuPh1e1J9HQBhyA/GWE+xoEsdt0iHM88m1HkB2hdf3WeRhcDFCWcaKoWvc/Q6bKm7180df6kbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937028; c=relaxed/simple;
	bh=MicJO6VQOlqk3bh+xxhxDm1sZ/18fAljo8C9cBO59zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/dNeqUYZv3ZMaCDREhEYlsSPGXijKpLdMAAnC30jCUDQVWeZYusNmAutwv/Te48GJhf1KJYURP7Bc3OQUQLAz3p/qYaZcInpYUqkfsx+w1QFBLNeonM9v+490a63G87InrK9/5XhijakKkpwPwQ6lUaWgUsYXUhas2GBDPanw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vQDbnETd; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707937026; x=1739473026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omL38NVwfGsbDjixlU5jvsuvhCCl/L+s3D2aF/nZp3U=;
  b=vQDbnETd87L0soOjgj7pM9EcCYe1HAD5fSzoIQDjOxRbFNcdWfZIqbGc
   yTXaScvM2fI6aO5CLPyeKh2P6JGq++tUbNTMzklciSFquKId+/PldOcwB
   Pl4QLiG6hPXePYMHQ5blNMQXqF48tYGX5mOZP5ME0vL+Dju2k5vUVY0Al
   E=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705363200"; 
   d="scan'208";a="274162213"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 18:57:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:52438]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id f25c10ae-cc76-4cc6-814b-7717e135a67e; Wed, 14 Feb 2024 18:57:04 +0000 (UTC)
X-Farcaster-Flow-ID: f25c10ae-cc76-4cc6-814b-7717e135a67e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 18:57:03 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 18:57:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <joannelkoong@gmail.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net] dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
Date: Wed, 14 Feb 2024 10:56:49 -0800
Message-ID: <20240214185649.96945-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJ29sLgpz1sEMJ9K=PtJy7RY4HOyg2+ykuCJ2ico_629g@mail.gmail.com>
References: <CANn89iJ29sLgpz1sEMJ9K=PtJy7RY4HOyg2+ykuCJ2ico_629g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 10:05:33 +0100
> On Tue, Feb 13, 2024 at 10:42 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
> > repro.
> >
> >   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
> >
> > However, the syzkaller's log hinted that connect() failed just before
> > the warning due to FAULT_INJECTION.  [1]
> >
> > When connect() is called for an unbound socket, we search for an
> > available ephemeral port.  If a bhash bucket exists for the port, we
> > call __inet_check_established() or __inet6_check_established() to check
> > if the bucket is reusable.
> >
> > If reusable, we add the socket into ehash and set inet_sk(sk)->inet_num.
> >
> > Later, we look up the corresponding bhash2 bucket and try to allocate
> > it if it does not exist.
> >
> > Although it rarely occurs in real use, if the allocation fails, we must
> > revert the changes by check_established().  Otherwise, an unconnected
> > socket could illegally occupy an ehash entry.
> >
> > Note that we do not put tw back into ehash because sk might have
> > already responded to a packet for tw and it would be better to free
> > tw earlier under such memory presure.
> >
> > [0]:
> >
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > v2:
> >   * Unhash twsk from bhash/bhash2
> >
> > v1: https://lore.kernel.org/netdev/20240209025409.27235-1-kuniyu@amazon.com/
> > ---
> >  net/ipv4/inet_hashtables.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 93e9193df544..b22c71f93297 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -1130,10 +1130,31 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
> >         return 0;
> >
> >  error:
> > +       if (sk_hashed(sk)) {
> > +               spinlock_t *lock = inet_ehash_lockp(hinfo, sk->sk_hash);
> > +
> > +               sock_prot_inuse_add(net, sk->sk_prot, -1);
> > +
> > +               spin_lock(lock);
> > +               sk_nulls_del_node_init_rcu(sk);
> > +               spin_unlock(lock);
> > +
> > +               sk->sk_hash = 0;
> > +               inet_sk(sk)->inet_sport = 0;
> > +               inet_sk(sk)->inet_num = 0;
> > +
> > +               if (tw)
> > +                       inet_twsk_bind_unhash(tw, hinfo);
> > +       }
> > +
> >         spin_unlock(&head2->lock);
> >         if (tb_created)
> >                 inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
> >         spin_unlock_bh(&head->lock);
> > +
> > +       if (tw)
> > +               inet_twsk_deschedule_put(tw);
> 
> Please make sure to call this while BH is still disabled.
> 
> 
>     spin_unlock(&head->lock);
>     if (tw)
>         inet_twsk_deschedule_put(tw);
>    local_bh_enable();

Sure, will update in v3 and post a followup for the existing
inet_twsk_deschedule_put() to net-next later.

Thanks!

