Return-Path: <netdev+bounces-102399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0473A902C8E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9E81C20F28
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86E152189;
	Mon, 10 Jun 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a1/NuHKL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD33C0C
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062757; cv=none; b=mF9h8u3En/KWbQiWf5KBzIin24dhhtWqzACb4UOfnOGR3al4roq2/QDjwp0NAD5eoUa63FlcHHv2kUDKFAdJzm7tjmbDqHh7FiSg6iTErRCwL3COKC29XqtGVnocGiEQRFYkIIE+aby4kduHXI5Ezm0lQh6J1UDPt+shm+mWk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062757; c=relaxed/simple;
	bh=OqkA0UPvlRdQPJGUri/ZF92EwajdAT6XejacbGEXkOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIiwfmkfk+XIMt7S6TDwZRRKuHwzYD6aIPpRREVyb2e24mZBocpwyZobsuBxZqUDaKLEq92ruruTWm3LozpClKAuKDTgHYpQLCd4F75NPkwgv6mLPy2K6RgO5J1u05OClTSbRq3z7qxcG7QTNOKV3fnWq8o+giLCN0Q8Cv1U9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a1/NuHKL; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718062756; x=1749598756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bwz6Gs9x24OyB5KenPDoUiITL5Rl9a6PsxLsqZ+7Dw=;
  b=a1/NuHKLOpRdY2QPC7TNFx6jyWWS0o9QxNnd+Du8xWbVP2jpvFHYHv4S
   ov44LY8uOZ0sbnXP1I+7GbO4YdG77oXPEK6P3Xy3vCb8aZV+aw6OLMK6h
   SGh5c6rcr+Br/rm6L64zpAhCRjQPz3jDJ4iDkV/ud9INk4x+ZgHsHmi+v
   0=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="732589013"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:39:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:43683]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.133:2525] with esmtp (Farcaster)
 id 99e4ff76-908e-450c-be86-9e5a291c88f5; Mon, 10 Jun 2024 23:39:10 +0000 (UTC)
X-Farcaster-Flow-ID: 99e4ff76-908e-450c-be86-9e5a291c88f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 23:39:09 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 23:39:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 01/11] af_unix: Define locking order for unix_table_double_lock().
Date: Mon, 10 Jun 2024 16:38:57 -0700
Message-ID: <20240610233857.78697-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c2s2h5hd6obrraim5u7nbqu3wcp5pm5srtf4772qxmrlaugdps@7gjdbcf6v7dx>
References: <c2s2h5hd6obrraim5u7nbqu3wcp5pm5srtf4772qxmrlaugdps@7gjdbcf6v7dx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Mon, 10 Jun 2024 18:43:44 -0400
> On Mon, Jun 10, 2024 at 03:34:51PM -0700, Kuniyuki Iwashima wrote:
> > When created, AF_UNIX socket is put into net->unx.table.buckets[],
> > and the hash is stored in sk->sk_hash.
> > 
> >   * unbound socket  : 0 <= sk_hash <= UNIX_HASH_MOD
> > 
> > When bind() is called, the socket could be moved to another bucket.
> > 
> >   * pathname socket : 0 <= sk_hash <= UNIX_HASH_MOD
> >   * abstract socket : UNIX_HASH_MOD + 1 <= sk_hash <= UNIX_HASH_MOD * 2 + 1
> > 
> > Then, we call unix_table_double_lock() which locks a single bucket
> > or two.
> > 
> > Let's define the order as unix_table_lock_cmp_fn() instead of using
> > spin_lock_nested().
> > 
> > The locking is always done in ascending order of sk->sk_hash, which
> > is the index of buckets/locks array allocated by kvmalloc_array().
> > 
> >   sk_hash_A < sk_hash_B
> >   <=> &locks[sk_hash_A].dep_map < &locks[sk_hash_B].dep_map
> > 
> > So, the relation of two sk->sk_hash can be derived from the addresses
> > of dep_map in the array of locks.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 3821f8945b1e..b0a9891c0384 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -126,6 +126,13 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
> >   *    hash table is protected with spinlock.
> >   *    each socket state is protected by separate spinlock.
> >   */
> > +#ifdef CONFIG_PROVE_LOCKING
> > +static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
> > +				  const struct lockdep_map *b)
> > +{
> > +	return a < b ? -1 : 0;
> > +}
> > +#endif
> 
> This should be a proper comparison function: -1 for less than, 0 for
> equal, 1 for greater than.
> 
> I've got a cmp_int() macro in bcachefs that does this nicely.

So, should this be :

  a < b ? -1 : 1

?

or

  ((a > b) - (b < a))

?

I think most double_lock functions eliminate the a == b case beforehand,
and even ->cmp_fn() is not called for such a recursive case because
debug_spin_lock_before() triggers BUG() then.

Initially I added the same macro, but checkpatch complains about it,
and I thought the current form is easier to understand because it's
the actual comparison used in the double lock part.

Also, there is a case, where we just want to return an error without
classifying it into 0 or 1.

I rather think we should define something like this on the lockdep side.

  enum lockdep_cmp_result {
    LOCKDEP_CMP_SAFE = -1,
    LOCKDEP_CMP_DEADLOCK,
  };

What do you think ?

