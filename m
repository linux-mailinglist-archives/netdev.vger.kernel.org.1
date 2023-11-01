Return-Path: <netdev+bounces-45591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1907DE7B0
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962C9B20DD8
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B391B294;
	Wed,  1 Nov 2023 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie6s0Sq/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643F33FA
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:53:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F20119
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698875605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nVOrNNEvEeNpHZhIU0FeOrFYxSmUjF+L9aGYQKszoBM=;
	b=ie6s0Sq/W9/nuViG+n14/w6mT4xKtxt3LPGi31rIhUtIx5abx8+BIYeVWJFD+aOqmq/aCH
	zC+Z+bY4E/SYoeTCJ5YrPyucBFbnqr6RRPOLodw1U8KhQOhzJfgVjmvi8V8f5PO4ZusWDB
	UnK9bMPoUNnRE2yHtH2H+W3IlyLd4tQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-HQtPyiL5MASzO23C9z4MFQ-1; Wed,
 01 Nov 2023 17:53:20 -0400
X-MC-Unique: HQtPyiL5MASzO23C9z4MFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3FC3299E74C;
	Wed,  1 Nov 2023 21:53:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with SMTP id 67D5F25C0;
	Wed,  1 Nov 2023 21:53:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Nov 2023 22:52:18 +0100 (CET)
Date: Wed, 1 Nov 2023 22:52:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101215214.GD32034@redhat.com>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <20231101205238.GI1957730@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101205238.GI1957730@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 11/01, Al Viro wrote:
>
> On Wed, Nov 01, 2023 at 09:23:03PM +0100, Oleg Nesterov wrote:
>
> > Yes this is confusing. Again, even the documentation is wrong! That is why
> > I am trying to remove the misuse of read_seqbegin_or_lock(), then I am going
> > to change the semantics of need_seqretry() to enforce the locking on the 2nd
> > pass.
>
> What for?  Sure, documentation needs to be fixed,

So do you agree that the current usage of read_seqbegin_or_lock() in
rxrpc_find_service_conn_rcu() is misleading ? Do you agree it can use
read_seqbegin/read_seqretry without changing the current behaviour?

> but *not* in direction you
> suggested in that patch.

Hmm. then how do you think the doc should be changed? To describe the
current behaviour.

> Why would you want to force that "switch to locked on the second pass" policy
> on every possible caller?

Because this is what (I think) read_seqbegin_or_lock() is supposed to do.
It should take the lock for writing if the lockless access failed. At least
according to the documentation.

This needs another discussion and perhaps this makes no sense. But I'd
like to turn need_seqretry(seq) into something like

	static inline int need_seqretry(seqlock_t *lock, int *seq)
	{
		int ret = !(*seq & 1) && read_seqretry(lock, *seq);

		if (ret)
			*seq = 1; /* make this counter odd */

		return ret;
	}

and update the users which actually want read_seqlock_excl() on the 2nd pass.
thread_group_cputime(), fs/d_path.c and fs/dcache.c.

For example, __dentry_path()

	--- a/fs/d_path.c
	+++ b/fs/d_path.c
	@@ -349,10 +349,9 @@ static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
		}
		if (!(seq & 1))
			rcu_read_unlock();
	-	if (need_seqretry(&rename_lock, seq)) {
	-		seq = 1;
	+	if (need_seqretry(&rename_lock, &seq))
			goto restart;
	-	}
	+
		done_seqretry(&rename_lock, seq);
		if (b.len == p->len)
			prepend_char(&b, '/');


but again, this need another discussion.

Oleg.


