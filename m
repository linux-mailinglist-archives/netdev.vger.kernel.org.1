Return-Path: <netdev+bounces-75535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165DC86A6E6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DAE282E2F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664F4A2A;
	Wed, 28 Feb 2024 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IRZji9O6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D32200A8
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088568; cv=none; b=g0X3Wxf5brvn+X/R3i8HehivrmxnZbCSDF0pUkokgL8O1jToUV8Pr2aAq4vSVDxzmpDwbgPl+soyK9XRC409iKfhlQH1kvg3tnlrlYIc6wLuAPplaBz4uoMA0q8he4qXLweo3gqMTaEd6RVE8+r49nDECHdxOoHqlnHvHUt73Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088568; c=relaxed/simple;
	bh=lnEz3T66Ewa829IyRPpyRiCdoeZHjgYZNA+ani71Uow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYTms29QOvxAJDNkAO5UrYMQAhcwGvGCho8r2Fmv2KLr93LCGzvrG8BajaSas1y2luG7vgtzPhnht7XDaveV/z+kpXhtal3xhJhQVX99htz+A3mLcYm6BkGQaQNe+QAQ4+ityKG+VXbA40EF4tueXAhJ5JxEO1BPKTjua8W2VOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IRZji9O6; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709088566; x=1740624566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iBc6FqPdRg/hhgNMXkZlHQWaKSkZtRhzMsyP0VCCrVY=;
  b=IRZji9O6hA4X/bbrW9vND8AgprmfO8pNBJCln9Bq29soWeN1lhEEBGma
   XGSw2mk0gagwXbv0XoFZJzx096UHmnC9ODNxWcl0qomba3DRSIvQWNy44
   L2J9pYo2rjGsPkJWhkVxhmE7iPyqF+jg1lwx6D23GIfRVfhmCs+rCNoCg
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,189,1705363200"; 
   d="scan'208";a="384137111"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 02:49:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:2652]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.64:2525] with esmtp (Farcaster)
 id 7ca3c5e2-f8b1-4d1e-a042-8dda5a61f81c; Wed, 28 Feb 2024 02:49:23 +0000 (UTC)
X-Farcaster-Flow-ID: 7ca3c5e2-f8b1-4d1e-a042-8dda5a61f81c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 02:49:23 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 28 Feb 2024 02:49:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 05/14] af_unix: Detect Strongly Connected Components.
Date: Tue, 27 Feb 2024 18:49:12 -0800
Message-ID: <20240228024912.30244-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8880a6a22b774b25db9c4a2bc95487521170de20.camel@redhat.com>
References: <8880a6a22b774b25db9c4a2bc95487521170de20.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Feb 2024 12:02:27 +0100
> On Fri, 2024-02-23 at 13:39 -0800, Kuniyuki Iwashima wrote:
> > In the new GC, we use a simple graph algorithm, Tarjan's Strongly
> > Connected Components (SCC) algorithm, to find cyclic references.
> > 
> > The algorithm visits every vertex exactly once using depth-first
> > search (DFS).  We implement it without recursion so that no one
> > can abuse it.
> > 
> > There could be multiple graphs, so we iterate unix_unvisited_vertices
> > in unix_walk_scc() and do DFS in __unix_walk_scc(), where we move
> > visited vertices to another list, unix_visited_vertices, not to
> > restart DFS twice on a visited vertex later in unix_walk_scc().
> > 
> > DFS starts by pushing an input vertex to a stack and assigning it
> > a unique number.  Two fields, index and lowlink, are initialised
> > with the number, but lowlink could be updated later during DFS.
> > 
> > If a vertex has an edge to an unvisited inflight vertex, we visit
> > it and do the same processing.  So, we will have vertices in the
> > stack in the order they appear and number them consecutively in
> > the same order.
> > 
> > If a vertex has a back-edge to a visited vertex in the stack,
> > we update the predecessor's lowlink with the successor's index.
> > 
> > After iterating edges from the vertex, we check if its index
> > equals its lowlink.
> > 
> > If the lowlink is different from the index, it shows there was a
> > back-edge.  Then, we propagate the lowlink to its predecessor and
> > go back to the predecessor to resume checking from the next edge
> > of the back-edge.
> > 
> > If the lowlink is the same as the index, we pop vertices before
> > and including the vertex from the stack.  Then, the set of vertices
> > is SCC, possibly forming a cycle.  At the same time, we move the
> > vertices to unix_visited_vertices.
> > 
> > When we finish the algorithm, all vertices in each SCC will be
> > linked via unix_vertex.scc_entry.
> > 
> > Let's take an example.  We have a graph including five inflight
> > vertices (F is not inflight):
> > 
> >   A -> B -> C -> D -> E (-> F)
> >        ^         |
> >        `---------'
> > 
> > Suppose that we start DFS from C.  We will visit C, D, and B first
> > and initialise their index and lowlink.  Then, the stack looks like
> > this:
> > 
> >   > B = (3, 3)  (index, lowlink)
> >     D = (2, 2)
> >     C = (1, 1)
> > 
> > When checking B's edge to C, we update B's lowlink with C's index
> > and propagate it to D.
> > 
> >     B = (3, 1)  (index, lowlink)
> >   > D = (2, 1)
> >     C = (1, 1)
> > 
> > Next, we visit E, which has no edge to an inflight vertex.
> > 
> >   > E = (4, 4)  (index, lowlink)
> >     B = (3, 1)
> >     D = (2, 1)
> >     C = (1, 1)
> > 
> > When we leave from E, its index and lowlink are the same, so we
> > pop E from the stack as single-vertex SCC.  Next, we leave from
> > D but do nothing because its lowlink is different from its index.
> > 
> >     B = (3, 1)  (index, lowlink)
> >     D = (2, 1)
> >   > C = (1, 1)
> > 
> > Then, we leave from C, whose index and lowlink are the same, so
> > we pop B, D and C as SCC.
> > 
> > Last, we do DFS for the rest of vertices, A, which is also a
> > single-vertex SCC.
> > 
> > Finally, each unix_vertex.scc_entry is linked as follows:
> > 
> >   A -.  B -> C -> D  E -.
> >   ^  |  ^         |  ^  |
> >   `--'  `---------'  `--'
> > 
> > We use SCC later to decide whether we can garbage-collect the
> > sockets.
> > 
> > Note that we still cannot detect SCC properly if an edge points
> > to an embryo socket.  The following two patches will sort it out.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/af_unix.h |  5 +++
> >  net/unix/garbage.c    | 82 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> > 
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index f31ad1166346..67736767b616 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -32,13 +32,18 @@ void wait_for_unix_gc(struct scm_fp_list *fpl);
> >  struct unix_vertex {
> >  	struct list_head edges;
> >  	struct list_head entry;
> > +	struct list_head scc_entry;
> >  	unsigned long out_degree;
> > +	unsigned long index;
> > +	unsigned long lowlink;
> > +	bool on_stack;
> >  };
> >  
> >  struct unix_edge {
> >  	struct unix_sock *predecessor;
> >  	struct unix_sock *successor;
> >  	struct list_head vertex_entry;
> > +	struct list_head stack_entry;
> >  };
> >  
> >  struct sock *unix_peer_get(struct sock *sk);
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index e8fe08796d02..7e90663513f9 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -103,6 +103,11 @@ struct unix_sock *unix_get_socket(struct file *filp)
> >  
> >  static LIST_HEAD(unix_unvisited_vertices);
> >  
> > +enum unix_vertex_index {
> > +	UNIX_VERTEX_INDEX_UNVISITED,
> > +	UNIX_VERTEX_INDEX_START,
> > +};
> > +
> >  static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
> >  {
> >  	struct unix_vertex *vertex = edge->predecessor->vertex;
> > @@ -245,6 +250,81 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
> >  	unix_free_vertices(fpl);
> >  }
> >  
> > +static LIST_HEAD(unix_visited_vertices);
> > +
> > +static void __unix_walk_scc(struct unix_vertex *vertex)
> > +{
> > +	unsigned long index = UNIX_VERTEX_INDEX_START;
> > +	LIST_HEAD(vertex_stack);
> > +	struct unix_edge *edge;
> > +	LIST_HEAD(edge_stack);
> > +
> > +next_vertex:
> > +	vertex->index = index;
> > +	vertex->lowlink = index;
> > +	index++;
> > +
> > +	vertex->on_stack = true;
> > +	list_add(&vertex->scc_entry, &vertex_stack);
> > +
> > +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> > +		struct unix_vertex *next_vertex = edge->successor->vertex;
> > +
> > +		if (!next_vertex)
> > +			continue;
> > +
> > +		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
> > +			list_add(&edge->stack_entry, &edge_stack);
> > +
> > +			vertex = next_vertex;
> > +			goto next_vertex;
> > +prev_vertex:
> > +			next_vertex = vertex;
> > +
> > +			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
> > +			list_del_init(&edge->stack_entry);
> > +
> > +			vertex = edge->predecessor->vertex;
> > +
> > +			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
> > +		} else if (edge->successor->vertex->on_stack) {
> 
> It looks like you can replace ^^^^^^^^^^^^^^^^^^^^ with 'next_vertex'
> and that would be more readable.

Good catch, will update in v2.


> 
> IMHO more importantly: this code is fairly untrivial, I think that a
> significant amount of comments would help the review and the long term
> maintenance - even if everything is crystal clear and obvious to you,
> restating the obvious in a comment would help me ;)

Thanks for your review and sorry for bothering you..  yeah, I understand
that but it was hard to comment how the graph algorithm works without
examples.

Actually, I drew dozens of diagrams in iPad with many patterns to ensure
that the code works, so I tried to fill the gap with the long commit
message (and incremental changes for later optimisations).

I'll try to split this commit to DFS and Tarjan part to make review
a bit easier and add more useful comments.

Thank you!

