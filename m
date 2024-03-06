Return-Path: <netdev+bounces-78094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A58740B4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DAB22129
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50913F01E;
	Wed,  6 Mar 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n8hx9+wD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2799140366
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754269; cv=none; b=U/jrWKUXlEsxMhRuxBE+ytMNfjOtM+hY8+qYkLkQID9nfbe9vi2xToZZm4uxn2QQlZYdD6K94EeaSdyK1KHkqoN1fpFwPF8S/WcllszJaHwVngDzyk/09+2tbdyLSYrwsBZMScEx6IjTtxX7NPWSm9PGiWlq6DIZ20XcSis+Vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754269; c=relaxed/simple;
	bh=fuGtPlX2Ap572MqW62DCXuZqvcj9QY4yEE7xGo1AszY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmVbuYpEy3vjEz2FD2PilrGMY1IEPaaU89VjaxJrqd/5i13sZe5PeObtBgUmUMhMg7xkCRwotC2Ibw52LiSewFKzOFBmgfJ8cP2M7qaS7TIqjwxucGmfKlpX5nRmHynkPA0kN180UBNItCFebqFISnHrO0TUfS9f3Sc5OnbWzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n8hx9+wD; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709754269; x=1741290269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ekF3R80uHCflxNu1nAB+TNZHhkHxGBapKAo2oE07Rg=;
  b=n8hx9+wDnb9IVL0hQUwKZggvrTVGTn2dPY/AUSVe8wImjflCYLBNGanB
   5tM3F0JsztWFJFaX1tYxcXo1xt9uZZJMiU7TQOpgGvfwY7ChI0JqRM4ji
   LV2tCFNOLjg3K8k+SGCED+Hm9h1ftU3/3CiqSh8ot+pFm7cWdckf3Yydb
   k=;
X-IronPort-AV: E=Sophos;i="6.06,209,1705363200"; 
   d="scan'208";a="385972693"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:44:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:3682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.13:2525] with esmtp (Farcaster)
 id 5377eca2-8a50-4588-bf76-4e2fee2d8d3a; Wed, 6 Mar 2024 19:44:23 +0000 (UTC)
X-Farcaster-Flow-ID: 5377eca2-8a50-4588-bf76-4e2fee2d8d3a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 19:44:22 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 19:44:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 02/15] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Wed, 6 Mar 2024 11:44:12 -0800
Message-ID: <20240306194412.11255-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <344810ddca4b0baa9d6844c5100ff091dcda50aa.camel@redhat.com>
References: <344810ddca4b0baa9d6844c5100ff091dcda50aa.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 05 Mar 2024 09:47:04 +0100
> On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> > As with the previous patch, we preallocate to skb's scm_fp_list an
> > array of struct unix_edge in the number of inflight AF_UNIX fds.
> > 
> > There we just preallocate memory and do not use immediately because
> > sendmsg() could fail after this point.  The actual use will be in
> > the next patch.
> > 
> > When we queue skb with inflight edges, we will set the inflight
> > socket's unix_sock as unix_edge->predecessor and the receiver's
> > unix_sock as successor, and then we will link the edge to the
> > inflight socket's unix_vertex.edges.
> > 
> > Note that we set NULL to cloned scm_fp_list.edges in scm_fp_dup()
> > so that MSG_PEEK does not change the shape of the directed graph.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  include/net/af_unix.h | 6 ++++++
> >  include/net/scm.h     | 5 +++++
> >  net/core/scm.c        | 2 ++
> >  net/unix/garbage.c    | 6 ++++++
> >  4 files changed, 19 insertions(+)
> > 
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index c270877a5256..55c4abc26a71 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -33,6 +33,12 @@ struct unix_vertex {
> >  	unsigned long out_degree;
> >  };
> >  
> > +struct unix_edge {
> > +	struct unix_sock *predecessor;
> > +	struct unix_sock *successor;
> > +	struct list_head vertex_entry;
> > +};
> > +
> >  struct sock *unix_peer_get(struct sock *sk);
> >  
> >  #define UNIX_HASH_MOD	(256 - 1)
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index e34321b6e204..5f5154e5096d 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -23,12 +23,17 @@ struct scm_creds {
> >  	kgid_t	gid;
> >  };
> >  
> > +#ifdef CONFIG_UNIX
> > +struct unix_edge;
> > +#endif
> > +
> >  struct scm_fp_list {
> >  	short			count;
> >  	short			count_unix;
> >  	short			max;
> >  #ifdef CONFIG_UNIX
> >  	struct list_head	vertices;
> > +	struct unix_edge	*edges;
> >  #endif
> >  	struct user_struct	*user;
> >  	struct file		*fp[SCM_MAX_FD];
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 87dfec1c3378..1bcc8a2d65e3 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
> >  		fpl->max = SCM_MAX_FD;
> >  		fpl->user = NULL;
> >  #if IS_ENABLED(CONFIG_UNIX)
> > +		fpl->edges = NULL;
> >  		INIT_LIST_HEAD(&fpl->vertices);
> >  #endif
> >  	}
> > @@ -383,6 +384,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
> >  		new_fpl->max = new_fpl->count;
> >  		new_fpl->user = get_uid(fpl->user);
> >  #if IS_ENABLED(CONFIG_UNIX)
> > +		new_fpl->edges = NULL;
> >  		INIT_LIST_HEAD(&new_fpl->vertices);
> >  #endif
> >  	}
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 75bdf66b81df..f31917683288 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -127,6 +127,11 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
> >  		list_add(&vertex->entry, &fpl->vertices);
> >  	}
> >  
> > +	fpl->edges = kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
> > +				    GFP_KERNEL_ACCOUNT);
> 
> If I read correctly, the total amount of additionally memory used will
> be proportional to vertices num + edges num.

Correct.


> Can you please provide a
> the real figures for some reasonable unix fd numbers (say a small
> table), to verify this memory usage is reasonable?

First, regarding per-sock change.

Before this series, unix_sock is 1920 bytes.
After this series, unix_sock is 1856 bytes, and unix_vertex is 72 bytes.

The delta is (1856 + 72) - 1920 = 8 bytes.

But, there is 8-bytes hole in unix_sock after the series, and the last
oob_skb can be moved there.  Then, the size decrease 4 bytes in total.
So, we can ignore the delta with a follow-up patch moving oob_skb (and
other fields) to pack unix_sock.

---8<---
$ pahole -C unix_sock vmlinux
struct unix_sock {
...
	spinlock_t                 lock;                 /*  1592    64 */

	/* XXX 8 bytes hole, try to pack */
...
	/* XXX 4 bytes hole, try to pack */

	struct sk_buff *           oob_skb;              /*  1840     8 */

	/* size: 1856, cachelines: 29, members: 13 */
---8<---


Second, regarding unix_edge.

sk_buff is 224 bytes, and scm_fp_list, which has struct file
pointer with the fixed-size array fp[253], is 2064 bytes.

After this series, unix_edge (48 bytes) is added to each AF_UNIX
fds.

Before this series: 224 + 2064 = 2288 bytes
After this series : 2288 + 48 * n bytes

In our distro, systemd is the major user receiving AF_UNIX fd at
boot time, ssh login, etc, and each skb has only one AF_UNIX fd.
In that case, skb has 48 bytes (2%) increase in size.

If we fully populate skb with 253 AF_UNIX fds, it will have about
12KB increase, but this is unlikely.

