Return-Path: <netdev+bounces-136307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027599A1471
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32C91F22C88
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D61D1305;
	Wed, 16 Oct 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Knj/lPSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66054409
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112089; cv=none; b=qqH5yefQ0dV1R1rLviLm/7XtPfS7cXltzAfg24qKj+lNkwWc7xaJlj4HIRcNslGizW7lqRpchfHbAm1MRSOXzwIpnFnr0OlvqD9sL6t/cRhJcsVl6n+gWHKiil2wPF3vTH8B1nDbdDiSbZGRkw7zm663Mmp+7LrtRiaCQBagZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112089; c=relaxed/simple;
	bh=rMssAUEjb7edq1ciY4Smbdj8KQjGS4FssLUZrdvsB6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrSxu1Yu8U1nidsGGnBSM5DKJYbXKC/u65OPp4ifVqwEqdodJ6bYqxX9X+JnpNwFXdwW5JLVo9NF7tJbKGUY4RHe4xQ7PkxTDfna6jjcIgMtXBMVQaOZj/gH8Zcu1K1xFVBzJUZzwfVl9CpN5mws/cER63jEis++6LS3r6rgDnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Knj/lPSt; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729112087; x=1760648087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JU6XS3XLYHV8plPjyQwe8txH0wPA5GGVyLtpqu2j2N4=;
  b=Knj/lPStxYHVt0BqK2kboqFykNxJrNketbIdCqCPucj9UNWzEsaStINd
   KqL1Fdw5J+YzpWXzX1bgsOGL+eM8E29LOG/4zQxmTnfwXy1h4U6UGmXoQ
   8cfOeC2HwtpaHaDHrSXHen0ECJQ63Sg0x6CkOim088i+mt/eRbbtf9Wu1
   M=;
X-IronPort-AV: E=Sophos;i="6.11,209,1725321600"; 
   d="scan'208";a="138782748"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 20:54:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:53917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id eeb36a92-5969-4280-895f-8c8b1976f0ee; Wed, 16 Oct 2024 20:54:44 +0000 (UTC)
X-Farcaster-Flow-ID: eeb36a92-5969-4280-895f-8c8b1976f0ee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 20:54:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 20:54:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 3/6] Convert neigh_* seq_file functions to use hlist
Date: Wed, 16 Oct 2024 13:54:37 -0700
Message-ID: <20241016205437.12812-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016091152.3504685-1-gnaaman@drivenets.com>
References: <20241016091152.3504685-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Wed, 16 Oct 2024 09:11:52 +0000
> > > -		if (++state->bucket >= (1 << nht->hash_shift))
> > > -			break;
> > 
> > Let's keep this,
> > 
> > 
> > > +		while (!n && ++state->bucket < (1 << nht->hash_shift))
> > > +			n = neigh_first_rcu(&nht->hash_heads[state->bucket]);
> > >  
> > > -		n = rcu_dereference(nht->hash_buckets[state->bucket]);
> > 
> > and simply fetch neigh_first_entry().
> > 
> > Then, we can let the next loop handle the termination condition
> > and keep the code simple.
> 
> Unfortunately `hlist_for_each_entry_continue_rcu` dereferences `n`
> first thing using `hlist_next_rcu`, before checking for NULL:

Right, and I noticed we even can't use neigh_first_entry() after
checking against NULL because the first entry will be skipped by
hlist_for_each_entry_continue_rcu().

> 
>     #define hlist_for_each_entry_continue_rcu(pos, member)			\
>     	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu( \
>     			&(pos)->member)), typeof(*(pos)), member);	\
>     	     pos;							\
>     	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
>     			&(pos)->member)), typeof(*(pos)), member))
> 
> If I'm using it, I have to add a null-check after calling `neigh_first_entry`.
> 
> Another alternative is to use `hlist_for_each_entry_from_rcu`,
> but it'll require calling `next` one time before the loop.
> 
> Is this preferable?

How about factorising the operations inside loops and use
hlist_for_each_entry_continue() and call neigh_get_first()
in neigh_get_next() ?

completely not tested:

---8<---
static struct neighbour *neigh_get_valid(struct seq_file *seq,
					 struct neighbour *n,
					 loff_t *pos)
{
	struct net *net = seq_file_net(seq);

	if (!net_eq(dev_net(n->dev), net))
		return NULL;

	if (state->neigh_sub_iter) {
		loff_t fakep = 0;
		void *v;

		v = state->neigh_sub_iter(state, n, pos ? pos : &fakep);
		if (!v)
			return NULL;
		if (pos)
			return v;
	}

	if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
		return n;

	if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
		return n;

	return NULL;
}

static struct neighbour *neigh_get_first(struct seq_file *seq)
{
	struct neigh_seq_state *state = seq->private;
	struct neigh_hash_table *nht = state->nht;
	struct net *net = seq_file_net(seq);
	struct neighbour *n, *tmp;

	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;

	while (++state->bucket < (1 << nht->hash_shift)) {
		neigh_for_each(n, &nht->hash_heads[state->bucket]) {
			tmp = neigh_get_valid(seq, n, pos);
			if (tmp)
				return tmp;
		}
	}

	return NULL;
}

static struct neighbour *neigh_get_next(struct seq_file *seq,
					struct neighbour *n,
					loff_t *pos)
{
	struct neigh_seq_state *state = seq->private;
	struct neigh_hash_table *nht = state->nht;
	struct net *net = seq_file_net(seq);
	struct neighbour *tmp;

	if (state->neigh_sub_iter) {
		void *v = state->neigh_sub_iter(state, n, pos);

		if (v)
			return n;
	}

	hlist_for_each_entry_continue(n, hash) {
		tmp = neigh_get_valid(seq, n, pos);
		if (tmp) {
			n = tmp;
			goto out;
		}
	}

	n = neigh_get_first(seq);
out:
	if (n && pos)
		--(*pos);

	return n;
}
---8<---

