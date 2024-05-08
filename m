Return-Path: <netdev+bounces-94673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C88C0292
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29D01F23074
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09F1095A;
	Wed,  8 May 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rt67XP0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3C101CF
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187947; cv=none; b=S7Ph4DnwMYnoMaxl7JaXitNu2GKL6QIhnIFSF8e9pPY7NAloHK/jqtcP5Fqx/mkO9yKQbvLjdf7v0liX/mghC/w0JhfF6ERm85pnxFrCTlQdn9X0ysbBRin/3PCWwqOo3NDHMYAQ+L7PhfcVfxuicc0cI1DLY5LJ21GHrkPr/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187947; c=relaxed/simple;
	bh=YM5rdc01b/HCfvTOerWcbQ9Pj2tLOmeZuIbfvc7sD14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6yOspOnqxpsnmCmAGj0/6a9h+hloPO0Zwp+uuaXqLQRQepuuZ6J6MGTqMR0VIkzg8LFIPcnaiQCdCx7zNxPNq0fo1+kfiaOtHZCin3Cq3I9ekOxsD/VKboPQIkTg8u+wi7FADDoRQMD1a2vpGfhNZwg0BQxGHKA5FbZQ3QCebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rt67XP0o; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715187946; x=1746723946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idT5NdDyC7hjHNmQJTaduGlrEZ1CZS8pF2AfY01Nemk=;
  b=Rt67XP0oaEw0kwBI+uXa504XHKVnS2l1WXbSG7BeyUgO25x+qqPGdqFa
   S0uNxy/VidVOzT7GmeTBFfta0G5rOcT9COF2prOiTQ3XDGn0AMwpV8SGs
   bq3qyO9BC84CCDznMCC8bj9ThWOjiNZqa5K8IUWUqqZeDoNA6oZU66wTG
   k=;
X-IronPort-AV: E=Sophos;i="6.08,145,1712620800"; 
   d="scan'208";a="294909137"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:05:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:60281]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.195:2525] with esmtp (Farcaster)
 id 9c080b07-9078-42d0-ad47-224326295590; Wed, 8 May 2024 17:05:42 +0000 (UTC)
X-Farcaster-Flow-ID: 9c080b07-9078-42d0-ad47-224326295590
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 17:05:35 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.140.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 17:05:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/6] af_unix: Save the number of loops in inflight graph.
Date: Wed, 8 May 2024 10:05:25 -0700
Message-ID: <20240508170525.49710-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <705af521482fdae1fddbd594e003e07fc3c9ec61.camel@redhat.com>
References: <705af521482fdae1fddbd594e003e07fc3c9ec61.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 08 May 2024 12:08:48 +0200
> On Tue, 2024-05-07 at 09:11 -0700, Kuniyuki Iwashima wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Tue, 07 May 2024 15:54:33 +0200
> > > On Fri, 2024-05-03 at 15:31 -0700, Kuniyuki Iwashima wrote:
> > > > unix_walk_scc_fast() calls unix_scc_cyclic() for every SCC so that we
> > > > can make unix_graph_maybe_cyclic false when all SCC are cleaned up.
> > > > 
> > > > If we count the number of loops in the graph during Tarjan's algorithm,
> > > > we need not call unix_scc_cyclic() in unix_walk_scc_fast().
> > > > 
> > > > Instead, we can just decrement the number when calling unix_collect_skb()
> > > > and update unix_graph_maybe_cyclic based on the count.
> > > > 
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/unix/garbage.c | 19 +++++++++++--------
> > > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > > index 1f8b8cdfcdc8..7ffb80dd422c 100644
> > > > --- a/net/unix/garbage.c
> > > > +++ b/net/unix/garbage.c
> > > > @@ -405,6 +405,7 @@ static bool unix_scc_cyclic(struct list_head *scc)
> > > >  
> > > >  static LIST_HEAD(unix_visited_vertices);
> > > >  static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
> > > > +static unsigned long unix_graph_circles;
> > > >  
> > > >  static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
> > > >  			    struct sk_buff_head *hitlist)
> > > > @@ -494,8 +495,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
> > > >  
> > > >  		if (scc_dead)
> > > >  			unix_collect_skb(&scc, hitlist);
> > > > -		else if (!unix_graph_maybe_cyclic)
> > > > -			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
> > > > +		else if (unix_scc_cyclic(&scc))
> > > > +			unix_graph_circles++;
> > > >  
> > > >  		list_del(&scc);
> > > >  	}
> > > > @@ -509,7 +510,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
> > > >  {
> > > >  	unsigned long last_index = UNIX_VERTEX_INDEX_START;
> > > >  
> > > > -	unix_graph_maybe_cyclic = false;
> > > > +	unix_graph_circles = 0;
> > > >  
> > > >  	/* Visit every vertex exactly once.
> > > >  	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
> > > > @@ -524,13 +525,12 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
> > > >  	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
> > > >  	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
> > > >  
> > > > +	unix_graph_maybe_cyclic = !!unix_graph_circles;
> > > >  	unix_graph_grouped = true;
> > > >  }
> > > >  
> > > >  static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
> > > >  {
> > > > -	unix_graph_maybe_cyclic = false;
> > > > -
> > > >  	while (!list_empty(&unix_unvisited_vertices)) {
> > > >  		struct unix_vertex *vertex;
> > > >  		struct list_head scc;
> > > > @@ -546,15 +546,18 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
> > > >  				scc_dead = unix_vertex_dead(vertex);
> > > >  		}
> > > >  
> > > > -		if (scc_dead)
> > > > +		if (scc_dead) {
> > > >  			unix_collect_skb(&scc, hitlist);
> > > > -		else if (!unix_graph_maybe_cyclic)
> > > > -			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
> > > > +			unix_graph_circles--;
> > > 
> > > Possibly WARN_ON_ONCE(unix_graph_circles < 0) ?
> > 
> > Will add in v2.
> > 
> > > 
> > > I find this patch a little scaring - meaning I can't understand it
> > > fully,
> > > I'm wondering if it would make any sense to postpone this patch
> > > to the next cycle?
> > 
> > It's fine by me to postpone patch 2 - 5, but it would be appreciated
> > if patch 1 makes it to this cycle.
> 
> Yes, patch 1 looks fine and safe to me. Feel free to re-submit that one
> individually right now, with my Acked-by tag.

Thanks, will do!

