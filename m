Return-Path: <netdev+bounces-133165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE0995274
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AB41C22520
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227B1DF755;
	Tue,  8 Oct 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QADCXBO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153A1DEFF4
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399209; cv=none; b=VAYvfL+N6ZQg8tTusCTfouXYUKUBG8ohkwmNxdYWivtVhDKytx8wBppIxj866HtKR7ru/6z8r3Fl1lVuC+JfvqD9I1uaoxZmIcqKxKvZaYIlvkVDNlO/WU/CjfrfdZgAGy9w3jQX6C0Swl4rfpcCTNuPkvHwFQiasQSH1OBr83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399209; c=relaxed/simple;
	bh=dJ+phDu608OwfoSQL8OjPwYHi2jN2anIiwC0f3VDGvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgARIHUOLVLyaXP2s/9e+N70QEvYja6p+PKNxSv7cV+B8DXDPAnqCiIV78PGtvMaQJ12Y0wF91A1HUdd62KmBgdo7SRI4f4obWnQndgNtHzhvgdLRoJKaQ4ZCzWmZOoA9wAqYgHsn0T30Xmg3KTA5ejZ+rs6BToDIyXZlKievuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QADCXBO/; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728399209; x=1759935209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMFonxy8Bo1S3VCyJqYN3YIMsw0zvRhenazbSD7CoWU=;
  b=QADCXBO/50Q7m9H0cwPj1Jo5I5frQS7pL+lcAzNoyh30bdCOpNUVnDVJ
   MFCRzCaUwUO4eDX8oQ9/AI7BPTijzeWrfjOn0odTZOSmlnsQdFx9t0fVA
   lzL+xQAW8iwkncWmkdqZxl+YnT5cNzBkPPc+EnElzJMBCk0s5nWhsUNBM
   M=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="764745431"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 14:53:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:44772]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.239:2525] with esmtp (Farcaster)
 id 7fd53068-02e6-496b-8ecd-2fbbcd3312ac; Tue, 8 Oct 2024 14:53:20 +0000 (UTC)
X-Farcaster-Flow-ID: 7fd53068-02e6-496b-8ecd-2fbbcd3312ac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 14:53:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 14:53:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist
Date: Tue, 8 Oct 2024 07:53:10 -0700
Message-ID: <20241008145310.85530-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008073855.811502-1-gnaaman@drivenets.com>
References: <20241008073855.811502-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Tue,  8 Oct 2024 07:38:55 +0000
> > > @@ -388,21 +366,20 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
> > >  
> > >  	for (i = 0; i < (1 << nht->hash_shift); i++) {
> > >  		struct neighbour *n;
> > > -		struct neighbour __rcu **np = &nht->hash_buckets[i];
> > > +		struct neighbour __rcu **np =
> > > +			(struct neighbour __rcu **)&nht->hash_buckets[i].first;
> > 
> > This will be no longer needed for doubly linked list,
> 
> This is not as-necessary with a doubly-linked list, but unfortunately
> I cannot eliminate it completely, as the `n` might be released in the loop
> body.
> 
> I can convert this function to use a `struct neighour *next` instead,
> if it is more palatable.

Yes, using hlist_for_each_entry_safe() is more preferable.

Mixing for() and while() is harder to read.


[...]
> > > @@ -693,11 +666,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
> > >  		goto out_tbl_unlock;
> > >  	}
> > >  
> > > -	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
> > > -					    lockdep_is_held(&tbl->lock));
> > > -	     n1 != NULL;
> > > -	     n1 = rcu_dereference_protected(n1->next,
> > > -			lockdep_is_held(&tbl->lock))) {
> > > +	hlist_for_each_entry_rcu(n1,
> > > +				 &nht->hash_buckets[hash_val],
> > > +				 list,
> > > +				 lockdep_is_held(&tbl->lock)) {
> > 
> > Let's define hlist_for_each_entry_rcu() as neigh-specific macro.
> 
> Can you elaborate on this?
> Do you want the `list` parameter to be eliminated?

I mean like

#define neigh_for_each(...)		\
	hlist_for_each_entry(...)

#define neigh_for_each_rcu(...)		\
	hlist_for_each_entry_rcu(...)

are better if there's repeated arguments.

