Return-Path: <netdev+bounces-75827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728186B4CC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43C51F24E42
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290066EEFC;
	Wed, 28 Feb 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c2qAgT/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553493FB8A
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137557; cv=none; b=OJh2U3biNQQvY8esbZj5ZUP/UXB7Ay71iUY0r0NhYAd7IFXEGhX1Jy4ErG+pmWtK4iALfx5r9cTYX1Knk4eOAEVHfgwKkXmqg7GIUOcSkxRTKtoEReMSEQQGPPyUYKnsIzl/WQPuR+OZxiCtWymVBKrrV8JQ+0a42hnDyCWPpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137557; c=relaxed/simple;
	bh=wih1JKV72ORMQfl8VJmt7lknKg0nXa0X2LRHhc3i8SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fas7Qcbd2euckY6OcoyO7ApJk7Kts3Xojrc3Ugjkexo1iGLAqp0Y/gCpYFH/H8mzOmywd8+T99fEQhGtsIYfq4o86mvp8qgqOB9OXOLVj3xoKGXaY1JXnC+75ni7HmUorZFy45gOkWF31MMwz8c0jNQFwEoZzTPc6CYr0XgevR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c2qAgT/j; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709137555; x=1740673555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXfhK+tekuChPX/9enwE6ve7b69rWKhqPxUtYKU6Rhs=;
  b=c2qAgT/jcNnBgf2ggSvfuM5xGgx/Bdq0Ck2qr2f9E0//TfMgJ8s35NTu
   ovcbT6lZBtxDILw6EKAp9syAStQijvX8sTrMlnuM0TR9UCA82uEylcZTJ
   0e6I3ezPskdRRz6JdFYVwzQ+e5F8KIxy5XMG4XChfN0mex4rbQP0sTnaE
   k=;
X-IronPort-AV: E=Sophos;i="6.06,190,1705363200"; 
   d="scan'208";a="69443588"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:25:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:24625]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.165:2525] with esmtp (Farcaster)
 id 840e2e89-56c4-4269-898e-99efe84524b7; Wed, 28 Feb 2024 16:25:51 +0000 (UTC)
X-Farcaster-Flow-ID: 840e2e89-56c4-4269-898e-99efe84524b7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 16:25:50 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 16:25:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 11/14] af_unix: Assign a unique index to SCC.
Date: Wed, 28 Feb 2024 08:25:39 -0800
Message-ID: <20240228162539.98084-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3adcdaf1bd20b37640a92593d643964bf49297c2.camel@redhat.com>
References: <3adcdaf1bd20b37640a92593d643964bf49297c2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 28 Feb 2024 08:49:46 +0100
> On Tue, 2024-02-27 at 19:05 -0800, Kuniyuki Iwashima wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Tue, 27 Feb 2024 12:19:40 +0100
> > > On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > > > The definition of the lowlink in Tarjan's algorithm is the
> > > > smallest index of a vertex that is reachable with at most one
> > > > back-edge in SCC.  This is not useful for a cross-edge.
> > > > 
> > > > If we start traversing from A in the following graph, the final
> > > > lowlink of D is 3.  The cross-edge here is one between D and C.
> > > > 
> > > >   A -> B -> D   D = (4, 3)  (index, lowlink)
> > > >   ^    |    |   C = (3, 1)
> > > >   |    V    |   B = (2, 1)
> > > >   `--- C <--'   A = (1, 1)
> > > > 
> > > > This is because the lowlink of D is updated with the index of C.
> > > > 
> > > > In the following patch, we detect a dead SCC by checking two
> > > > conditions for each vertex.
> > > > 
> > > >   1) vertex has no edge directed to another SCC (no bridge)
> > > >   2) vertex's out_degree is the same as the refcount of its file
> > > > 
> > > > If 1) is false, there is a receiver of all fds of the SCC and
> > > > its ancestor SCC.
> > > > 
> > > > To evaluate 1), we need to assign a unique index to each SCC and
> > > > assign it to all vertices in the SCC.
> > > > 
> > > > This patch changes the lowlink update logic for cross-edge so
> > > > that in the example above, the lowlink of D is updated with the
> > > > lowlink of C.
> > > > 
> > > >   A -> B -> D   D = (4, 1)  (index, lowlink)
> > > >   ^    |    |   C = (3, 1)
> > > >   |    V    |   B = (2, 1)
> > > >   `--- C <--'   A = (1, 1)
> > > > 
> > > > Then, all vertices in the same SCC have the same lowlink, and we
> > > > can quickly find the bridge connecting to different SCC if exists.
> > > > 
> > > > However, it is no longer called lowlink, so we rename it to
> > > > scc_index.  (It's sometimes called lowpoint.)
> > > > 
> > > > Also, we add a global variable to hold the last index used in DFS
> > > > so that we do not reset the initial index in each DFS.
> > > > 
> > > > This patch can be squashed to the SCC detection patch but is
> > > > split deliberately for anyone wondering why lowlink is not used
> > > > as used in the original Tarjan's algorithm and many reference
> > > > implementations.
> > > > 
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  include/net/af_unix.h |  2 +-
> > > >  net/unix/garbage.c    | 15 ++++++++-------
> > > >  2 files changed, 9 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > > > index ec040caaa4b5..696d997a5ac9 100644
> > > > --- a/include/net/af_unix.h
> > > > +++ b/include/net/af_unix.h
> > > > @@ -36,7 +36,7 @@ struct unix_vertex {
> > > >  	struct list_head scc_entry;
> > > >  	unsigned long out_degree;
> > > >  	unsigned long index;
> > > > -	unsigned long lowlink;
> > > > +	unsigned long scc_index;
> > > >  };
> > > >  
> > > >  struct unix_edge {
> > > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > > index 1d9a0498dec5..0eb1610c96d7 100644
> > > > --- a/net/unix/garbage.c
> > > > +++ b/net/unix/garbage.c
> > > > @@ -308,18 +308,18 @@ static bool unix_scc_cyclic(struct list_head *scc)
> > > >  
> > > >  static LIST_HEAD(unix_visited_vertices);
> > > >  static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
> > > > +static unsigned long unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
> > > >  
> > > >  static void __unix_walk_scc(struct unix_vertex *vertex)
> > > >  {
> > > > -	unsigned long index = UNIX_VERTEX_INDEX_START;
> > > >  	LIST_HEAD(vertex_stack);
> > > >  	struct unix_edge *edge;
> > > >  	LIST_HEAD(edge_stack);
> > > >  
> > > >  next_vertex:
> > > > -	vertex->index = index;
> > > > -	vertex->lowlink = index;
> > > > -	index++;
> > > > +	vertex->index = unix_vertex_last_index;
> > > > +	vertex->scc_index = unix_vertex_last_index;
> > > > +	unix_vertex_last_index++;
> > > >  
> > > >  	list_add(&vertex->scc_entry, &vertex_stack);
> > > >  
> > > > @@ -342,13 +342,13 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
> > > >  
> > > >  			vertex = edge->predecessor->vertex;
> > > >  
> > > > -			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
> > > > +			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
> > > >  		} else if (next_vertex->index != unix_vertex_grouped_index) {
> > > > -			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
> > > > +			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
> > > 
> > > I guess the above will break when unix_vertex_last_index wraps around,
> > > or am I low on coffee? (I guess there is not such a thing as enough
> > > coffee to allow me reviewing this whole series at once ;)
> > > 
> > > Can we expect a wrap around in host with (surprisingly very) long
> > > uptimes? 
> > 
> > Then, the number of inflight AF_UNIX sockets is at least 2^64 - 1.
> 
> Isn't "unix_vertex_last_index" value preserved across consecutive cg
> run? I though we could reach wrap around after a lot of gc runs...

It's preserved across consecutive DFS in a single gc run, but
unix_walk_scc() always reset it.  So, if it's wrapped, there
would be too many sockets.

I used unix_vertex_last_index elsewhere in the initial draft,
but now local variable could be better here.

