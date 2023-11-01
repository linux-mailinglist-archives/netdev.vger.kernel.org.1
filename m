Return-Path: <netdev+bounces-45588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6427DE756
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B0BB20CE8
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921818E2A;
	Wed,  1 Nov 2023 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfPUQ2Nc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FD19BA1
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:22:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E1D127
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698873757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j4Q5+IwvvLZciE9qd6dWmjNxBjBLvEzq9VGta2vDxk4=;
	b=DfPUQ2NcDCxE0extyQGpHKWkgsxsL95Et5Xe2YVJO2CGvdLxAvCi9nb13xFoBEOurLkW6g
	FkyYY+Kv7k7N/V/vY8EunmqYGb8u2Q3/1dbEsveHseEKcVMbpZDvEWTSeTO/JqZ9fLfitx
	0m0Pme8188J1Kqrkw0dMHn6f+mXWRJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-0sCK311YMxGieL5ndhB_xg-1; Wed, 01 Nov 2023 17:22:33 -0400
X-MC-Unique: 0sCK311YMxGieL5ndhB_xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55D8C101A529;
	Wed,  1 Nov 2023 21:22:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7CC91C060BA;
	Wed,  1 Nov 2023 21:22:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231101204023.GC32034@redhat.com>
References: <20231101204023.GC32034@redhat.com> <20231027095842.GA30868@redhat.com> <1952182.1698853516@warthog.procyon.org.uk> <20231101202302.GB32034@redhat.com>
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
Content-ID: <1959104.1698873750.1@warthog.procyon.org.uk>
Date: Wed, 01 Nov 2023 21:22:30 +0000
Message-ID: <1959105.1698873750@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Oleg Nesterov <oleg@redhat.com> wrote:

> Just none of read_seqbegin_or_lock/need_seqretry/done_seqretry
> helpers make any sense in this code.

I disagree.  I think in at least a couple of cases I do want a locked second
path - ideally locked shared if seqlock can be made to use an rwlock instead
of a spinlock.

David


