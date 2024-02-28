Return-Path: <netdev+bounces-75551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EB86A73A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D43C1F2C16C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4265200AC;
	Wed, 28 Feb 2024 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NO77tw4U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E317200A8
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091176; cv=none; b=XYvty2dn9agXS2BuJlAlxOJK82Et0Qj/0vQKWvLgoeOAhjDMdEuhCxq0dCJZxxOmbRPVv++ztTJ2cAYdOqljXq/4AnfH9be9sS+c8M2jCmK0o9PwWloAh+2mVNCwKBd3m4TxiOIBy0/+SAf2fLWSS7sonWzxzihTnGNx/6G4GGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091176; c=relaxed/simple;
	bh=MQL1BjQbltMSlxIQYCuEO2SbhO5U0Rg0VnOqGCLON3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTcpzhmicJlwIgKxVWGZ0jgj4XvMc+cqz20shITMyJ4WO82DXKoAHYyhWU5cjfgczcCAZ82B5xlZICnQiaPLoor+rtT3pgqEpOzCgjDDbSZ+aT2Ku+KPWcbe5aDpR5SLE9cfTw+A6U5fk4R9yfaRRlDA3aSKg0qJHD4CJsaIgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NO77tw4U; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709091175; x=1740627175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lo6PnvQjDLw/310gqCFMbPTbds88YyHGgnza6Gq9PRY=;
  b=NO77tw4UVWU2gAlZdQ2toQrpVNGLbELMyNOJTkNP3wDHgWg1foyCzYEO
   WtrxqP4cWDgI8ld2H3v/Z/giQxKVxHsM4Pt2yddmxa6vOhJAT2kH2hYVd
   ut9r4TJMo6zYpSUVPzAye85HBkBv57r1YgDTBQJK80AFvwt+DBoFrQc45
   M=;
X-IronPort-AV: E=Sophos;i="6.06,189,1705363200"; 
   d="scan'208";a="616058613"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:32:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:43325]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.3:2525] with esmtp (Farcaster)
 id 2d9b5f7a-9280-422d-9615-c5efa3f91725; Wed, 28 Feb 2024 03:32:52 +0000 (UTC)
X-Farcaster-Flow-ID: 2d9b5f7a-9280-422d-9615-c5efa3f91725
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 03:32:51 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 28 Feb 2024 03:32:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 13/14] af_unix: Replace garbage collection algorithm.
Date: Tue, 27 Feb 2024 19:32:41 -0800
Message-ID: <20240228033241.33471-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2e6eb578782dffcc8481992ba39181c74e2a7f80.camel@redhat.com>
References: <2e6eb578782dffcc8481992ba39181c74e2a7f80.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Feb 2024 12:36:51 +0100
> On Fri, 2024-02-23 at 13:40 -0800, Kuniyuki Iwashima wrote:
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 060e81be3614..59a87a997a4d 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -314,6 +314,48 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
> >  	return true;
> >  }
> >  
> > +static struct sk_buff_head hitlist;
> 
> I *think* hitlist could be replaced with a local variable in
> __unix_gc(), WDYT?

Actually it was a local variable in the first draft.

In the current GC impl, hitlist is passed down to functions,
but only the leaf function uses it, and I thought the global
variable would be easier to follow.

And now __unix_gc() is not called twice at the same time thanks
to workqueue, and hitlist can be a global variable.


> 
> > +
> > +static void unix_collect_skb(struct list_head *scc)
> > +{
> > +	struct unix_vertex *vertex;
> > +
> > +	list_for_each_entry_reverse(vertex, scc, scc_entry) {
> > +		struct sk_buff_head *queue;
> > +		struct unix_edge *edge;
> > +		struct unix_sock *u;
> > +
> > +		edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
> > +		u = edge->predecessor;
> > +		queue = &u->sk.sk_receive_queue;
> > +
> > +		spin_lock(&queue->lock);
> > +
> > +		if (u->sk.sk_state == TCP_LISTEN) {
> > +			struct sk_buff *skb;
> > +
> > +			skb_queue_walk(queue, skb) {
> > +				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
> > +
> > +				spin_lock(&embryo_queue->lock);
> 
> I'm wondering if and why lockdep would be happy about the above. I
> think this deserve at least a comment.

Ah, exactly, I guess lockdep is unhappy with it, but it would
be false positive anyway.  The inversion lock never happens.

I'll use spin_lock_nested() with a comment, or do

  - splice listener's list to local queue
  - unlock listener's queue
  - skb_queue_walk
    - lock child queue
    - splice
    - unlock child queue
  - lock listener's queue again
  - splice the child list back (to call unix_release_sock() later)


> 
> 
> > +				skb_queue_splice_init(embryo_queue, &hitlist);
> > +				spin_unlock(&embryo_queue->lock);
> > +			}
> > +		} else {
> > +			skb_queue_splice_init(queue, &hitlist);
> > +
> > +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > +			if (u->oob_skb) {
> > +				kfree_skb(u->oob_skb);
> 
> Similar question here. This happens under the u receive queue lock,
> could we his some complex lock dependency? what about moving oob_skb to
> hitlist instead?

oob_skb is just a pointer to skb which is put in the recv queue,
so it's already in the hitlist here.

But oob_skb has an additional refcount, so we need to call
kfree_skb() to decrement it, so we don't actually free it
here and later we do in __unix_gc().

