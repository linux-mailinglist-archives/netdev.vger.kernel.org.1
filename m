Return-Path: <netdev+bounces-75542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C086A70E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7F1B2AEAD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945081CD38;
	Wed, 28 Feb 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mzvG/TxQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24272107
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090095; cv=none; b=ivLIjXu4PTwz01DG1tfSjZZDzmsZOr/XhDbyaScn9yOYPvvKnD0pzKMTaKXI2znryIY8aMKhsqmUq/AatOUD61dmK8XzPyvLdNuGTIR2ntuRUCqKuuu4mWYqKvBb0pkrM++WMMFQkaUGv12WuGIEToAIots2LJ0oHPvwMYhaeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090095; c=relaxed/simple;
	bh=WarKF/SOZ7jtWkmkb3KFmxh/x1QWyhTbEtUwjHDvjmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slyGS/82zqKEu+leS2vjxY72qTubMY2DMmQpZ+fK9OvjuynZXRkDGs/LmBRF615uSkKyojCb8+KZ8gDupeeui2rEP+qYa2XCJgc5jrFttddvamPebpyMSrzBnPPoWj7PTHWP/+Fu7zNBuP4M/JN3CJEw1ebTBLiygn6Mg0J9VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mzvG/TxQ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709090095; x=1740626095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5M5QFhpMESPPQDIhgvMtmAW4CretKLB8aOQsQ7AFFtw=;
  b=mzvG/TxQTUdaIUnS6XmtAu/Mpd3qjg5UzalLLH2/Z0tYUnMc+FZub9OZ
   BwlHaZyOquJgZz8vcSn8cZH1LMSNmvOsBhhbKd+x/sNQ5TlVQzonGbIuA
   UrTDdw8UV8cRBDeeiRJTW7V/ADFq3I2LvmBHGoO6aqLJYni0spvrWzBlq
   s=;
X-IronPort-AV: E=Sophos;i="6.06,189,1705363200"; 
   d="scan'208";a="400162704"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:14:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:36169]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.237:2525] with esmtp (Farcaster)
 id d0becfc9-233c-4cb4-af4d-c42021d58675; Wed, 28 Feb 2024 03:14:47 +0000 (UTC)
X-Farcaster-Flow-ID: d0becfc9-233c-4cb4-af4d-c42021d58675
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 03:14:47 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 03:14:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 12/14] af_unix: Detect dead SCC.
Date: Tue, 27 Feb 2024 19:14:36 -0800
Message-ID: <20240228031436.31927-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3f629d0a45734914fbb64fdca80b44ff614aedb2.camel@redhat.com>
References: <3f629d0a45734914fbb64fdca80b44ff614aedb2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Feb 2024 12:25:56 +0100
> On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > When iterating SCC, we call unix_vertex_dead() for each vertex
> > to check if the vertex is close()d and has no bridge to another
> > SCC.
> > 
> > If both conditions are true for every vertex in SCC, we can
> > execute garbage collection for all skb in the SCC.
> > 
> > The actual garbage collection is done in the following patch,
> > replacing the old implementation.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/garbage.c | 37 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 0eb1610c96d7..060e81be3614 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -288,6 +288,32 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
> >  	unix_free_vertices(fpl);
> >  }
> >  
> > +static bool unix_vertex_dead(struct unix_vertex *vertex)
> > +{
> > +	struct unix_edge *edge;
> > +	struct unix_sock *u;
> > +	long total_ref;
> > +
> > +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> > +		struct unix_vertex *next_vertex = unix_edge_successor(edge);
> > +
> > +		if (!next_vertex)
> > +			return false;
> > +
> > +		if (next_vertex->scc_index != vertex->scc_index)
> > +			return false;
> > +	}
> > +
> > +	edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
> > +	u = edge->predecessor;
> > +	total_ref = file_count(u->sk.sk_socket->file);
> > +
> > +	if (total_ref != vertex->out_degree)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static bool unix_scc_cyclic(struct list_head *scc)
> >  {
> >  	struct unix_vertex *vertex;
> > @@ -350,6 +376,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
> >  
> >  	if (vertex->index == vertex->scc_index) {
> >  		struct list_head scc;
> > +		bool dead = true;
> 
> Very minor nit: the above variable 'sounds' alike referring to the
> current vertex, while instead it tracks a global status, what about
> 'all_dead' or 'gc_all'?

Exactly. I'll use scc_dead or gc_scc to be consistent
with unix_vertex_dead().

Thanks!

