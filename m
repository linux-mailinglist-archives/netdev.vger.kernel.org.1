Return-Path: <netdev+bounces-73372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3085C2EE
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8EC1F236F4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875176C83;
	Tue, 20 Feb 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i/w3m9O4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01176C73
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451100; cv=none; b=jN0wH1rOy5QqQQaQ1mxBIkZB981R8EQiG2/b3gS1AVTl2aScinHW0UPDF510cUfRJ7bWvDQZk1dZKXWIec0Bu7AD52LzKVK25lrSoMj8vv6zOCbJu8OrVoU3dgVPbzUBZqSQB0VM6MVHgzVrj9BWBfhecKjbDcbxSyGlKOHKch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451100; c=relaxed/simple;
	bh=Mv85M2vKAnRH9TBgBNSu5X7KLNhmiN05SLAr2z4ZJhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCEkcjwiPir51REBpHQQQAvHWs6uUKfobCbLOQ7F5fTJASiBezsV+M0BHScxxQ3o7B93bX3P0vNG7PdBkCjDzB/ZV754EaNYm3HYLQ6BUksBTbv76DIVFYQLSXWRq4Nk8PV6lWhUR3bZ8/vjZ7zFpt9mM4tuh8A8izoP82TzBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i/w3m9O4; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708451099; x=1739987099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvHfmRzvRteNr0osG5pTUa2xBnXltD2WqefdifAZbVI=;
  b=i/w3m9O4IK4kDO5dJ7Exes6k7hC6boCj+8Hgqyqj+G43IhlSPSOOsUGm
   MFICKM0rBMKDRwITIOMYGrtFyvx+EBgSs7R/e00YmaH+vMgoWc520cwc1
   pbeG4tvPk+N+0lVcTCcuntukBhZMek103lYiOGT4WPUpnhY94OWMBNfcP
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,174,1705363200"; 
   d="scan'208";a="705549001"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 17:44:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:38849]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.120:2525] with esmtp (Farcaster)
 id c3c5bbaa-a469-4bef-9680-9f742d0c289b; Tue, 20 Feb 2024 17:44:49 +0000 (UTC)
X-Farcaster-Flow-ID: c3c5bbaa-a469-4bef-9680-9f742d0c289b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 17:44:48 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 17:44:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 03/14] af_unix: Link struct unix_edge when queuing skb.
Date: Tue, 20 Feb 2024 09:44:37 -0800
Message-ID: <20240220174437.47356-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6aa8669ebc0b5a9b17f0a3256820560f8ba8e73a.camel@redhat.com>
References: <6aa8669ebc0b5a9b17f0a3256820560f8ba8e73a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Feb 2024 13:11:09 +0100
> On Fri, 2024-02-16 at 13:05 -0800, Kuniyuki Iwashima wrote:
> > Just before queuing skb with inflight fds, we call scm_stat_add(),
> > which is a good place to set up the preallocated struct unix_edge
> > in UNIXCB(skb).fp->edges.
> > 
> > Then, we call unix_add_edges() and construct the directed graph
> > as follows:
> > 
> >   1. Set the inflight socket's unix_vertex to unix_edge.predecessor
> >   2. Set the receiver's unix_vertex to unix_edge.successor
> >   3. Link unix_edge.entry to the inflight socket's unix_vertex.edges
> >   4. Link inflight socket's unix_vertex.entry to unix_unvisited_vertices.
> > 
> > Let's say we pass the fd of AF_UNIX socket A to B and the fd of B
> > to C.  The graph looks like this:
> > 
> >   +-------------------------+
> >   | unix_unvisited_vertices | <------------------------.
> >   +-------------------------+                          |
> >   +                                                    |
> >   |   +-------------+                +-------------+   |            +-------------+
> >   |   | unix_sock A |                | unix_sock B |   |            | unix_sock C |
> >   |   +-------------+                +-------------+   |            +-------------+
> >   |   | unix_vertex | <----.  .----> | unix_vertex | <-|--.  .----> | unix_vertex |
> >   |   | +-----------+      |  |      | +-----------+   |  |  |      | +-----------+
> >   `-> | |   entry   | +------------> | |   entry   | +-'  |  |      | |   entry   |
> >       | |-----------|      |  |      | |-----------|      |  |      | |-----------|
> >       | |   edges   | <-.  |  |      | |   edges   | <-.  |  |      | |   edges   |
> >       +-+-----------+   |  |  |      +-+-----------+   |  |  |      +-+-----------+
> >                         |  |  |                        |  |  |
> >   .---------------------'  |  |  .---------------------'  |  |
> >   |                        |  |  |                        |  |
> >   |   +-------------+      |  |  |   +-------------+      |  |
> >   |   |  unix_edge  |      |  |  |   |  unix_edge  |      |  |
> >   |   +-------------+      |  |  |   +-------------+      |  |
> >   `-> |    entry    |      |  |  `-> |    entry    |      |  |
> >       |-------------|      |  |      |-------------|      |  |
> >       | predecessor | +----'  |      | predecessor | +----'  |
> >       |-------------|         |      |-------------|         |
> >       |  successor  | +-------'      |  successor  | +-------'
> >       +-------------+                +-------------+
> > 
> > Henceforth, we denote such a graph as A -> B (-> C).
> > 
> > Now, we can express all inflight fd graphs that do not contain
> > embryo sockets.  The following two patches will support the
> > particular case.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/af_unix.h |  2 ++
> >  include/net/scm.h     |  1 +
> >  net/core/scm.c        |  2 ++
> >  net/unix/af_unix.c    |  8 +++++--
> >  net/unix/garbage.c    | 55 ++++++++++++++++++++++++++++++++++++++++++-
> >  5 files changed, 65 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index cab9dfb666f3..54d62467a70b 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -23,6 +23,8 @@ extern unsigned int unix_tot_inflight;
> >  void unix_inflight(struct user_struct *user, struct file *fp);
> >  void unix_notinflight(struct user_struct *user, struct file *fp);
> >  void unix_init_vertex(struct unix_sock *u);
> > +void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
> > +void unix_del_edges(struct scm_fp_list *fpl);
> >  int unix_alloc_edges(struct scm_fp_list *fpl);
> >  void unix_free_edges(struct scm_fp_list *fpl);
> >  void unix_gc(void);
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index a1142dee086c..7d807fe466a3 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -32,6 +32,7 @@ struct scm_fp_list {
> >  	short			count_unix;
> >  	short			max;
> >  #ifdef CONFIG_UNIX
> > +	bool			inflight;
> >  	struct unix_edge	*edges;
> >  #endif
> >  	struct user_struct	*user;
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index bc75b6927222..cad0c153ac93 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -88,6 +88,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
> >  		fpl->count = 0;
> >  		fpl->count_unix = 0;
> >  #if IS_ENABLED(CONFIG_UNIX)
> > +		fpl->inflight = false;
> >  		fpl->edges = NULL;
> >  #endif
> >  		fpl->max = SCM_MAX_FD;
> > @@ -381,6 +382,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
> >  			get_file(fpl->fp[i]);
> >  
> >  #if IS_ENABLED(CONFIG_UNIX)
> > +		new_fpl->inflight = false;
> >  		new_fpl->edges = NULL;
> >  #endif
> >  		new_fpl->max = new_fpl->count;
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 0391f66546a6..ea7bac18a781 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1956,8 +1956,10 @@ static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
> >  	struct scm_fp_list *fp = UNIXCB(skb).fp;
> >  	struct unix_sock *u = unix_sk(sk);
> >  
> > -	if (unlikely(fp && fp->count))
> > +	if (unlikely(fp && fp->count)) {
> >  		atomic_add(fp->count, &u->scm_stat.nr_fds);
> > +		unix_add_edges(fp, u);
> > +	}
> >  }
> >  
> >  static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
> > @@ -1965,8 +1967,10 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
> >  	struct scm_fp_list *fp = UNIXCB(skb).fp;
> >  	struct unix_sock *u = unix_sk(sk);
> >  
> > -	if (unlikely(fp && fp->count))
> > +	if (unlikely(fp && fp->count)) {
> >  		atomic_sub(fp->count, &u->scm_stat.nr_fds);
> > +		unix_del_edges(fp);
> > +	}
> >  }
> >  
> >  /*
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index ec998c7d6b4c..353416f38738 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -109,6 +109,57 @@ void unix_init_vertex(struct unix_sock *u)
> >  	INIT_LIST_HEAD(&vertex->edges);
> >  }
> >  
> > +DEFINE_SPINLOCK(unix_gc_lock);
> > +static LIST_HEAD(unix_unvisited_vertices);
> > +
> > +void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
> > +{
> > +	int i = 0, j = 0;
> > +
> > +	spin_lock(&unix_gc_lock);
> > +
> > +	while (i < fpl->count_unix) {
> > +		struct unix_sock *inflight = unix_get_socket(fpl->fp[j++]);
> > +		struct unix_edge *edge;
> > +
> > +		if (!inflight)
> > +			continue;
> > +
> > +		edge = fpl->edges + i++;
> > +		edge->predecessor = &inflight->vertex;
> > +		edge->successor = &receiver->vertex;
> > +
> > +		if (!edge->predecessor->out_degree++)
> > +			list_add_tail(&edge->predecessor->entry, &unix_unvisited_vertices);
> > +
> > +		list_add_tail(&edge->entry, &edge->predecessor->edges);
> 
> Note that I confusingly replied to the previous revision of this patch,
> but I think the points still stand.
> 
> 		INIT_LIST_HEAD(&edge->entry);	
> 
> disappeared from the above, but I can't find where it landed?!? 

Sorry, I forgot to mention this change in the coverletter.

Initially, I placed INIT_LIST_HEAD() in unix_alloc_edges(), but in v1,
I moved it to unix_add_edges(), and later I noticed it's unnecessary
in the first place because edge->entry is not used as head of a list,
so I removed it completely in v2.


From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Feb 2024 13:06:18 +0100
> Here  'edge->predecessor->entry' and 'edge->entry' refer to different
> object types right ? edge vs vertices. Perhaps using different field
> names could clarify the code a bit? 

Regarding the name of edge->entry, I agree a diffrent name would be
easy to understand.  I'll rename it to edge->vertex_entry unless there
is a better name :)

Thanks!

