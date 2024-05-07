Return-Path: <netdev+bounces-94172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6118BE86B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9088B1C23CBB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B45C16C43E;
	Tue,  7 May 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gN1h2TZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662F16190C
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098311; cv=none; b=TlRmFtjGKOQXR0e5cWUGvNppJcu02epW1BfSDDjE4SZJTzo4jsUDfI8g2RDE2LRB99hL1GW3IL0J+aiKcysDuz3YrqHtC+AGMXIjJyi8EH8R9gjLw53w/nX5A7gdSoYsZRnsfaabSrCRqS2I+odruXePhQZTABhuw7Bjgin2JD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098311; c=relaxed/simple;
	bh=xZ/3iMxpgvRHaLXprhtJySa9RxrkSnDAdlIpmM84sMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFnttPSGhCOcu+aENYBvngg3qGyuI88+BpMlD2VYIg9wEN2cOoH5Vlgb9zxn0b6Gt5rpw6H9EhuKNrTZu1kmUSm/X9WwXk8yo4W9wvp99LfLyNcJfhG2+i4GGDgN7/J2rop16eRjmpI0o76Cz1prt7WgmQYyrb4vi0Ph/A3J9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gN1h2TZs; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715098309; x=1746634309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FO8znyIcGRv6lOcPi45eg3Y8PiH/j3YzyVY3Fp2iPDE=;
  b=gN1h2TZsBetwf+qff76wWN6baLiBe5DNn6ghFK+E9VGSzQpftA+A9/Pq
   iczem9zSjFLMNMuLMNhpwMmUKWe/b1OaNcvHCJVm/vATkyDmzRaiXX4hI
   J3rjBgXlJrkbyb5hDhJ+qiJq1JKRR0hUYEwzzHvv/xfXwhXwvh5wZeMRV
   c=;
X-IronPort-AV: E=Sophos;i="6.08,142,1712620800"; 
   d="scan'208";a="87535354"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 16:11:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:39673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.175:2525] with esmtp (Farcaster)
 id 1196193e-d129-457b-a062-a04113b8164a; Tue, 7 May 2024 16:11:47 +0000 (UTC)
X-Farcaster-Flow-ID: 1196193e-d129-457b-a062-a04113b8164a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 16:11:46 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 7 May 2024 16:11:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/6] af_unix: Save the number of loops in inflight graph.
Date: Tue, 7 May 2024 09:11:36 -0700
Message-ID: <20240507161136.78482-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <37bb5b56bc27dbacfb48914f049efbb2bb8892f5.camel@redhat.com>
References: <37bb5b56bc27dbacfb48914f049efbb2bb8892f5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 07 May 2024 15:54:33 +0200
> On Fri, 2024-05-03 at 15:31 -0700, Kuniyuki Iwashima wrote:
> > unix_walk_scc_fast() calls unix_scc_cyclic() for every SCC so that we
> > can make unix_graph_maybe_cyclic false when all SCC are cleaned up.
> > 
> > If we count the number of loops in the graph during Tarjan's algorithm,
> > we need not call unix_scc_cyclic() in unix_walk_scc_fast().
> > 
> > Instead, we can just decrement the number when calling unix_collect_skb()
> > and update unix_graph_maybe_cyclic based on the count.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/garbage.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 1f8b8cdfcdc8..7ffb80dd422c 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -405,6 +405,7 @@ static bool unix_scc_cyclic(struct list_head *scc)
> >  
> >  static LIST_HEAD(unix_visited_vertices);
> >  static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
> > +static unsigned long unix_graph_circles;
> >  
> >  static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
> >  			    struct sk_buff_head *hitlist)
> > @@ -494,8 +495,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
> >  
> >  		if (scc_dead)
> >  			unix_collect_skb(&scc, hitlist);
> > -		else if (!unix_graph_maybe_cyclic)
> > -			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
> > +		else if (unix_scc_cyclic(&scc))
> > +			unix_graph_circles++;
> >  
> >  		list_del(&scc);
> >  	}
> > @@ -509,7 +510,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
> >  {
> >  	unsigned long last_index = UNIX_VERTEX_INDEX_START;
> >  
> > -	unix_graph_maybe_cyclic = false;
> > +	unix_graph_circles = 0;
> >  
> >  	/* Visit every vertex exactly once.
> >  	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
> > @@ -524,13 +525,12 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
> >  	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
> >  	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
> >  
> > +	unix_graph_maybe_cyclic = !!unix_graph_circles;
> >  	unix_graph_grouped = true;
> >  }
> >  
> >  static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
> >  {
> > -	unix_graph_maybe_cyclic = false;
> > -
> >  	while (!list_empty(&unix_unvisited_vertices)) {
> >  		struct unix_vertex *vertex;
> >  		struct list_head scc;
> > @@ -546,15 +546,18 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
> >  				scc_dead = unix_vertex_dead(vertex);
> >  		}
> >  
> > -		if (scc_dead)
> > +		if (scc_dead) {
> >  			unix_collect_skb(&scc, hitlist);
> > -		else if (!unix_graph_maybe_cyclic)
> > -			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
> > +			unix_graph_circles--;
> 
> Possibly WARN_ON_ONCE(unix_graph_circles < 0) ?

Will add in v2.

> 
> I find this patch a little scaring - meaning I can't understand it
> fully,
> I'm wondering if it would make any sense to postpone this patch
> to the next cycle?

It's fine by me to postpone patch 2 - 5, but it would be appreciated
if patch 1 makes it to this cycle.

Thanks!

