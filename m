Return-Path: <netdev+bounces-78108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E1874140
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCF41C23073
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540D140E29;
	Wed,  6 Mar 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tgjxO8Bs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB913F426
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756071; cv=none; b=DK+D62S5KzeQM4n8V8FXdP80LzZg+LPVYjEDbTnTZaSV9FqkqQD6hphAr6Agh8rCXEyG+AFn/YYxxn0z1c7T+ticEGpTP3wCl9H7X3sCPIN8+7VGGkOhQSXA2a7zgK1ZZyKUEjTJLg0nlKG6Z38t+j3DR3kGmJUcnxTYcDR4iUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756071; c=relaxed/simple;
	bh=xEr4WXEPg6Tx8lupot7wOFVIsr0EaxQ7qKu0mxVGtzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sfw3TAAE1nVjJmBT5MeRhaI4VMd7rapGuVUmrMNzaCWbeZFQDCOLHPZl+i+0zBfjxUh9XRZ6jX6hB0zUynzllq8shuvyml1LGXz6SJZIzVWKxErztxcstAyw8EVHkqAss77jAnnrHuDBiUvAQx0fDiAZ/hcaA++2CbM/Lrtx49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tgjxO8Bs; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709756070; x=1741292070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COCaMb7tTtrsSt1+zroH1vRkcDXT4mORzBqBj+mUh98=;
  b=tgjxO8BsYVGcQLoU5q1aBZxjygKWowsIe6hFeR7RBt+RhAD4SrIKNIjA
   OVKBQj/kdT2hm7Cq8leh1GRhZzkj5fhCCF4dEB2BztpBJXlAerw1cPalR
   ErUlVxZMLIeUrAWnZ29TnLbxxUO+6p/r8WJGFvriaG5fpmPEzkqSRKncz
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,209,1705363200"; 
   d="scan'208";a="402058468"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:14:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:64002]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id 41e33b09-4fe6-41cf-87e2-0713dc91597f; Wed, 6 Mar 2024 20:14:24 +0000 (UTC)
X-Farcaster-Flow-ID: 41e33b09-4fe6-41cf-87e2-0713dc91597f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 20:14:23 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 6 Mar 2024 20:14:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 05/15] af_unix: Iterate all vertices by DFS.
Date: Wed, 6 Mar 2024 12:14:13 -0800
Message-ID: <20240306201413.13082-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <25a99a706459304e9661881d413a342558a23372.camel@redhat.com>
References: <25a99a706459304e9661881d413a342558a23372.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 05 Mar 2024 09:53:17 +0100
> On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> > The new GC will use a depth first search graph algorithm to find
> > cyclic references.  The algorithm visits every vertex exactly once.
> > 
> > Here, we implement its DFS part without recursion so that no one
> > can abuse it.
> > 
> > unix_walk_scc() marks every vertex unvisited by initialising index
> > as UNIX_VERTEX_INDEX_UNVISITED, iterates inflight vertices in
> > unix_unvisited_vertices, and call __unix_walk_scc() to start DFS
> > from an arbitrary vertex.
> > 
> > __unix_walk_scc() iterates all edges starting from the vertex and
> > explores the neighbour vertices with DFS using edge_stack.
> > 
> > After visiting all neighbours, __unix_walk_scc() moves the visited
> > vertex to unix_visited_vertices so that unix_walk_scc() will not
> > restart DFS from the visited vertex.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/af_unix.h |  2 ++
> >  net/unix/garbage.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+)
> > 
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index f31ad1166346..970a91da2239 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -33,12 +33,14 @@ struct unix_vertex {
> >  	struct list_head edges;
> >  	struct list_head entry;
> >  	unsigned long out_degree;
> > +	unsigned long index;
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
> > index 84c8ea524a98..8b16ab9e240e 100644
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
> > @@ -241,6 +246,73 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
> >  	unix_free_vertices(fpl);
> >  }
> >  
> > +static LIST_HEAD(unix_visited_vertices);
> > +
> > +static void __unix_walk_scc(struct unix_vertex *vertex)
> > +{
> > +	unsigned long index = UNIX_VERTEX_INDEX_START;
> > +	struct unix_edge *edge;
> > +	LIST_HEAD(edge_stack);
> > +
> > +next_vertex:
> > +	vertex->index = index;
> > +	index++;
> > +
> > +	/* Explore neighbour vertices (receivers of the current vertex's fd). */
> > +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> > +		struct unix_vertex *next_vertex = edge->successor->vertex;
> > +
> > +		if (!next_vertex)
> > +			continue;
> > +
> > +		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
> > +			/* Iterative deepening depth first search
> > +			 *
> > +			 *   1. Push a forward edge to edge_stack and set
> > +			 *      the successor to vertex for the next iteration.
> > +			 */
> > +			list_add(&edge->stack_entry, &edge_stack);
> > +
> > +			vertex = next_vertex;
> > +			goto next_vertex;
> > +
> > +			/*   2. Pop the edge directed to the current vertex
> > +			 *      and restore the ancestor for backtracking.
> > +			 */
> > +prev_vertex:
> > +			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
> > +			list_del_init(&edge->stack_entry);
> > +
> > +			vertex = edge->predecessor->vertex;
> > +		}
> > +	}
> > +
> > +	/* Don't restart DFS from this vertex in unix_walk_scc(). */
> > +	list_move_tail(&vertex->entry, &unix_visited_vertices);
> > +
> > +	/* Need backtracking ? */
> > +	if (!list_empty(&edge_stack))
> > +		goto prev_vertex;
> > +}
> > +
> > +static void unix_walk_scc(void)
> > +{
> > +	struct unix_vertex *vertex;
> > +
> > +	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
> > +		vertex->index = UNIX_VERTEX_INDEX_UNVISITED;
> > +
> > +	/* Visit every vertex exactly once.
> > +	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
> > +	 */
> > +	while (!list_empty(&unix_unvisited_vertices)) {
> > +		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
> > +		__unix_walk_scc(vertex);
> 
> If I read correctly this is the single loop that could use the CPU for
> a possibly long time. I'm wondering if adding a cond_resched_lock()
> here (and possibly move the gc to a specific thread instead of a
> workqueue) would make sense.
> 
> It could avoid possibly very long starvation of the system wq and the
> used CPU.

TIL cond_resched_lock() :)

The loop is executed only when we add/del/update edges whose successor
is alredy inflight, and the loop takes O(|Vertex| + |Edges|).

If the loop takes so long, there would be too many inflight skbs, but
the current GC does not care such a situation.

The suggestion still makes sense, and then we could use mutex instead of
spinlock after kthread conversion.

Given the series has already 15 patches, I can add cond_resched_lock()
only in the next version and include the conversion in the follow-up
patches or include both changes as followup or do the conversion as prep.

What's the preferred option ?

Thanks!

