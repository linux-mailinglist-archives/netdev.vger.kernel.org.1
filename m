Return-Path: <netdev+bounces-102403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEE902D4B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4C11C20F9D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326A15B55D;
	Mon, 10 Jun 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="af2eMtyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0094158D8E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063933; cv=none; b=VrOc0evZrJNeXUv+hwY3+VLoAhY9dnCFD4pd3Ts+SsitmQVvqEtlElcErmqRxtG/tPRMv7pDP8LBEEwZ8dcvdNF15CFkt30rRk68XjAvHG4maqKIVeNkZRUqi9aAc16g9po1mL77cWbOv8Kt2+OAYEak8lxftRmbF1MnGd0dILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063933; c=relaxed/simple;
	bh=6K2yVUJtC47NeUjGKtpyZ9IZ4XbM2giMYoWoeP7qJEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV32/YkgM0m+NzWDs5ggaPoTbIHhkW0IcbzPNeu4BxKeK6pxsBAunbIe3++VV/XpCC8nMwTRc06jXVc/1Helb66r/Wu1/niuMTFWCK2M6TRU1topjL8VmFpx2qZHNnui+0KZ7b0wv+ieB4JPiYx/op/pRl5ayCkleSibMAP9omA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=af2eMtyg; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718063931; x=1749599931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxGfZGIy/x0/ZVqNKfkL+lXio0On1DUfEit2x1BqjU8=;
  b=af2eMtygFvCeZGZy5RJcRpb9pHTCJyGODIJgYgx3VxOYtAktUc0E+JLF
   BNYHW3m9Bikx9B+8LIS+BBlUu5b8wAcc+YfC2OuYRw5u9TwWzjuebt0E2
   qQmkJu7AgAdu8RL+JtpaNG7LpBO5DGKQe4ZIV70TZ1KUZCXHzavF6wNIU
   E=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="659834954"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:58:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:58959]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.85:2525] with esmtp (Farcaster)
 id 7afd84c4-d38c-4a1f-bf97-4ac8e7866641; Mon, 10 Jun 2024 23:58:47 +0000 (UTC)
X-Farcaster-Flow-ID: 7afd84c4-d38c-4a1f-bf97-4ac8e7866641
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 23:58:47 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 23:58:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 01/11] af_unix: Define locking order for unix_table_double_lock().
Date: Mon, 10 Jun 2024 16:58:36 -0700
Message-ID: <20240610235836.81964-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3vjpisr5vw5cts5h2wrtcqttgweyidtyjw5vgslhimtvy2oobu@b4hgsefmsmwj>
References: <3vjpisr5vw5cts5h2wrtcqttgweyidtyjw5vgslhimtvy2oobu@b4hgsefmsmwj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Mon, 10 Jun 2024 19:50:27 -0400
> On Mon, Jun 10, 2024 at 04:38:57PM -0700, Kuniyuki Iwashima wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > Date: Mon, 10 Jun 2024 18:43:44 -0400
> > > On Mon, Jun 10, 2024 at 03:34:51PM -0700, Kuniyuki Iwashima wrote:
> > > > When created, AF_UNIX socket is put into net->unx.table.buckets[],
> > > > and the hash is stored in sk->sk_hash.
> > > > 
> > > >   * unbound socket  : 0 <= sk_hash <= UNIX_HASH_MOD
> > > > 
> > > > When bind() is called, the socket could be moved to another bucket.
> > > > 
> > > >   * pathname socket : 0 <= sk_hash <= UNIX_HASH_MOD
> > > >   * abstract socket : UNIX_HASH_MOD + 1 <= sk_hash <= UNIX_HASH_MOD * 2 + 1
> > > > 
> > > > Then, we call unix_table_double_lock() which locks a single bucket
> > > > or two.
> > > > 
> > > > Let's define the order as unix_table_lock_cmp_fn() instead of using
> > > > spin_lock_nested().
> > > > 
> > > > The locking is always done in ascending order of sk->sk_hash, which
> > > > is the index of buckets/locks array allocated by kvmalloc_array().
> > > > 
> > > >   sk_hash_A < sk_hash_B
> > > >   <=> &locks[sk_hash_A].dep_map < &locks[sk_hash_B].dep_map
> > > > 
> > > > So, the relation of two sk->sk_hash can be derived from the addresses
> > > > of dep_map in the array of locks.
> > > > 
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/unix/af_unix.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > > index 3821f8945b1e..b0a9891c0384 100644
> > > > --- a/net/unix/af_unix.c
> > > > +++ b/net/unix/af_unix.c
> > > > @@ -126,6 +126,13 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
> > > >   *    hash table is protected with spinlock.
> > > >   *    each socket state is protected by separate spinlock.
> > > >   */
> > > > +#ifdef CONFIG_PROVE_LOCKING
> > > > +static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
> > > > +				  const struct lockdep_map *b)
> > > > +{
> > > > +	return a < b ? -1 : 0;
> > > > +}
> > > > +#endif
> > > 
> > > This should be a proper comparison function: -1 for less than, 0 for
> > > equal, 1 for greater than.
> > > 
> > > I've got a cmp_int() macro in bcachefs that does this nicely.
> > 
> > So, should this be :
> > 
> >   a < b ? -1 : 1
> > 
> > ?
> > 
> > or
> > 
> >   ((a > b) - (b < a))
> > 
> > ?
> > 
> > I think most double_lock functions eliminate the a == b case beforehand,
> > and even ->cmp_fn() is not called for such a recursive case because
> > debug_spin_lock_before() triggers BUG() then.
> > 
> > Initially I added the same macro, but checkpatch complains about it,
> > and I thought the current form is easier to understand because it's
> > the actual comparison used in the double lock part.
> > 
> > Also, there is a case, where we just want to return an error without
> > classifying it into 0 or 1.
> > 
> > I rather think we should define something like this on the lockdep side.
> > 
> >   enum lockdep_cmp_result {
> >     LOCKDEP_CMP_SAFE = -1,
> >     LOCKDEP_CMP_DEADLOCK,
> >   };
> > 
> > What do you think ?
> 
> No, we're defining an ordering, there's no need for an enum - this
> should work exactly the same as a comparison function that you pass to
> sort().
> 
> Comparison functions are no place to get fancy, they should be as
> standard as possible: you can get _crazy_ bugs resulting from buggy
> comparison functions that don't actually define a total ordering.

What should it return if we cannot define the total ordering like
when we only define the allowed list of ordering ?

See patch 8, the rule there is

  if the nested order is listening socket -> child socket, then ok,
  and otherwise, not.

So we don't know the clear ordering, equal or greater, but we know
it's actually illegal.

https://lore.kernel.org/netdev/20240610223501.73191-9-kuniyu@amazon.com/

