Return-Path: <netdev+bounces-45556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB387DE3F7
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233D4B20E0E
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45514292;
	Wed,  1 Nov 2023 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyYXbe5W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011514A8A
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:45:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E5111
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698853523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZfmnba+tHGz8pqoH154foHS+YLTOXshRrCAdJjTAkk=;
	b=fyYXbe5WhIy7TlCvLlDqCHtj1qr1uTDdUoAEMpr4cShCVYqLq+JR6aPXaTIlqGnqfJoUt+
	sWXFp9f+Dp5QiCMw80TPWbdf9KEJu/d2DxLUXzb9d/atOZNfWUeeWvfTxElBKOlEVDx7iC
	LXjnPU/pGEGfHAemGyo6PmRoCuhr8+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-rUr5MMA-OZqMoERtx8pLZQ-1; Wed, 01 Nov 2023 11:45:20 -0400
X-MC-Unique: rUr5MMA-OZqMoERtx8pLZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69EB1811E88;
	Wed,  1 Nov 2023 15:45:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCFC1C1290F;
	Wed,  1 Nov 2023 15:45:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231027095842.GA30868@redhat.com>
References: <20231027095842.GA30868@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather than read_seqbegin_or_lock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1952181.1698853516.1@warthog.procyon.org.uk>
Date: Wed, 01 Nov 2023 15:45:16 +0000
Message-ID: <1952182.1698853516@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Oleg Nesterov <oleg@redhat.com> wrote:

> read_seqbegin_or_lock() makes no sense unless you make "seq" odd
> after the lockless access failed.

I think you're wrong.

write_seqlock() turns it odd.  For instance, if the read lock is taken first:

	sequence seq	CPU 1				CPU 2
	======= =======	===============================	===============
	0
	0	0	seq = 0 // MUST BE EVEN ACCORDING TO DOC
	0	0	read_seqbegin_or_lock() [lockless]
			...
	1	0					write_seqlock()
	1	0	need_seqretry() [seq=even; sequence!=seq: retry]
	1	1	read_seqbegin_or_lock() [exclusive]
			-->spin_lock(lock);
	2	1					write_sequnlock()
			<--locked
			...
	2	1	need_seqretry()

However, if the write lock is taken first:

	sequence seq	CPU 1				CPU 2
	======= =======	===============================	===============
	0
	1						write_seqlock()
	1	0	seq = 0 // MUST BE EVEN ACCORDING TO DOC
	1	0	read_seqbegin_or_lock() [lockless]
	1	0	    __read_seqcount_begin()
				while (lock.sequence is odd)
				    cpu_relax();
	2	0					write_sequnlock()
	2	2		[loop end]
			...
	2	2	need_seqretry() [seq=even; sequence==seq; done]

Note that it spins in __read_seqcount_begin() until we get an even seq,
indicating that no write is currently in progress - at which point we can
perform a lockless pass.

> See thread_group_cputime() as an example, note that it does nextseq = 1 for
> the 2nd round.

That's not especially convincing.

David


