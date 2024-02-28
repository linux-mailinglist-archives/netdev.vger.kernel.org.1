Return-Path: <netdev+bounces-75538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF08A86A703
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EB51F2C761
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D531CF99;
	Wed, 28 Feb 2024 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FQo/LUcd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32681CF98
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089526; cv=none; b=Nzgw8+xPgl1u/RL+eslem3NQBQKFkaTwDKI4kib4tPWcsvDsKmBZ/CzsnV828bnETCbIfofCM1wZLj3VnUhzrq0t4zyYgbULSuv4TYnJ2nr1XZUPf09OBUq2x5w2Hd5eaQmyXdquimmKLmmDmnENw2UGnI7L/D43wtxRGLfOqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089526; c=relaxed/simple;
	bh=zdshkVZg47oBr91ao8xGj5DHDkvgf05wL3wO0zl/wJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk1TaBbpC2l5kxxeAwi014xAuMqG3LAxGc2Fgci0IxVTYm32zd21HfWZRkxAZMlQFxEIFe7AAYErv3I5akNqVaUBwi0TPrRicmPP8yl7u24tkMZwXe7f0yYSjZXm687Oz6uQp+qLRw+LDNlD7igQbpkXxhW0cTHxiVwXwtjsmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FQo/LUcd; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709089525; x=1740625525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luin3pZeRbyyt3Dh9s6VjK/1PNIweKh2l6XLWOV6uu8=;
  b=FQo/LUcdS6N0pMYoAG7f9BFbPZZLLkyEeLMAqQCaebFqzLTMDFJBQ6wF
   +DEanQ2mAMVPrJmEFeOhL7aL0jbDeRGhCYUp8YTEjZnIKhbtLUc5D7Z0l
   XRuvA9aSpSc/jilcjAT/GyAO1lPkoxPtDwxm+xayfNMDUVfkZ/s163H36
   c=;
X-IronPort-AV: E=Sophos;i="6.06,189,1705363200"; 
   d="scan'208";a="707327011"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:05:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:52771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.146:2525] with esmtp (Farcaster)
 id 4cf0e48f-9b40-40e7-8311-2833230eb1b6; Wed, 28 Feb 2024 03:05:19 +0000 (UTC)
X-Farcaster-Flow-ID: 4cf0e48f-9b40-40e7-8311-2833230eb1b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 03:05:18 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 28 Feb 2024 03:05:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 11/14] af_unix: Assign a unique index to SCC.
Date: Tue, 27 Feb 2024 19:05:07 -0800
Message-ID: <20240228030508.31297-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5f13e49d7aa3fb7ce51a5bea51268882a90a32c1.camel@redhat.com>
References: <5f13e49d7aa3fb7ce51a5bea51268882a90a32c1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Feb 2024 12:19:40 +0100
> On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > The definition of the lowlink in Tarjan's algorithm is the
> > smallest index of a vertex that is reachable with at most one
> > back-edge in SCC.  This is not useful for a cross-edge.
> > 
> > If we start traversing from A in the following graph, the final
> > lowlink of D is 3.  The cross-edge here is one between D and C.
> > 
> >   A -> B -> D   D = (4, 3)  (index, lowlink)
> >   ^    |    |   C = (3, 1)
> >   |    V    |   B = (2, 1)
> >   `--- C <--'   A = (1, 1)
> > 
> > This is because the lowlink of D is updated with the index of C.
> > 
> > In the following patch, we detect a dead SCC by checking two
> > conditions for each vertex.
> > 
> >   1) vertex has no edge directed to another SCC (no bridge)
> >   2) vertex's out_degree is the same as the refcount of its file
> > 
> > If 1) is false, there is a receiver of all fds of the SCC and
> > its ancestor SCC.
> > 
> > To evaluate 1), we need to assign a unique index to each SCC and
> > assign it to all vertices in the SCC.
> > 
> > This patch changes the lowlink update logic for cross-edge so
> > that in the example above, the lowlink of D is updated with the
> > lowlink of C.
> > 
> >   A -> B -> D   D = (4, 1)  (index, lowlink)
> >   ^    |    |   C = (3, 1)
> >   |    V    |   B = (2, 1)
> >   `--- C <--'   A = (1, 1)
> > 
> > Then, all vertices in the same SCC have the same lowlink, and we
> > can quickly find the bridge connecting to different SCC if exists.
> > 
> > However, it is no longer called lowlink, so we rename it to
> > scc_index.  (It's sometimes called lowpoint.)
> > 
> > Also, we add a global variable to hold the last index used in DFS
> > so that we do not reset the initial index in each DFS.
> > 
> > This patch can be squashed to the SCC detection patch but is
> > split deliberately for anyone wondering why lowlink is not used
> > as used in the original Tarjan's algorithm and many reference
> > implementations.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/af_unix.h |  2 +-
> >  net/unix/garbage.c    | 15 ++++++++-------
> >  2 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index ec040caaa4b5..696d997a5ac9 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -36,7 +36,7 @@ struct unix_vertex {
> >  	struct list_head scc_entry;
> >  	unsigned long out_degree;
> >  	unsigned long index;
> > -	unsigned long lowlink;
> > +	unsigned long scc_index;
> >  };
> >  
> >  struct unix_edge {
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 1d9a0498dec5..0eb1610c96d7 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -308,18 +308,18 @@ static bool unix_scc_cyclic(struct list_head *scc)
> >  
> >  static LIST_HEAD(unix_visited_vertices);
> >  static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
> > +static unsigned long unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
> >  
> >  static void __unix_walk_scc(struct unix_vertex *vertex)
> >  {
> > -	unsigned long index = UNIX_VERTEX_INDEX_START;
> >  	LIST_HEAD(vertex_stack);
> >  	struct unix_edge *edge;
> >  	LIST_HEAD(edge_stack);
> >  
> >  next_vertex:
> > -	vertex->index = index;
> > -	vertex->lowlink = index;
> > -	index++;
> > +	vertex->index = unix_vertex_last_index;
> > +	vertex->scc_index = unix_vertex_last_index;
> > +	unix_vertex_last_index++;
> >  
> >  	list_add(&vertex->scc_entry, &vertex_stack);
> >  
> > @@ -342,13 +342,13 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
> >  
> >  			vertex = edge->predecessor->vertex;
> >  
> > -			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
> > +			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
> >  		} else if (next_vertex->index != unix_vertex_grouped_index) {
> > -			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
> > +			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
> 
> I guess the above will break when unix_vertex_last_index wraps around,
> or am I low on coffee? (I guess there is not such a thing as enough
> coffee to allow me reviewing this whole series at once ;)
> 
> Can we expect a wrap around in host with (surprisingly very) long
> uptimes? 

Then, the number of inflight AF_UNIX sockets is at least 2^64 - 1.
After this series, struct unix_sock is 1024 bytes, so... the host
would have roughly

  2^10 * 2^64 == 2^74 bytes == 2^34 TBi == 17179869184 TBi

memory!

So, we need not expect a wrap around :)

