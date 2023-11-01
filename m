Return-Path: <netdev+bounces-45603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B6F7DE82D
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6685D28120C
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3E101EF;
	Wed,  1 Nov 2023 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx5NA3OI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7A6ABA
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:39:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EEB119
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698878375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABjpd7eCaubuoIcAkCypOQuyi+R5D9nKjFaDL8m4KlI=;
	b=hx5NA3OIlIbgDjYhVyrR9A0N/CIxtRWM6P4QiNIn6GGECjI+cqO85NsjZphCJt4Moa7kTT
	pokoTjPJ5iYWs+95a4lNr9xPrXY7qk1zr+2t5fw9gdso32oTXBSV0ming/YF3e86lpaZdi
	DJs75+HamwC5GDEbRqI0dbOMUikY7FQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-WkyWT0aEOriCjiNgzwuYEg-1; Wed, 01 Nov 2023 18:39:30 -0400
X-MC-Unique: WkyWT0aEOriCjiNgzwuYEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82BB3101A529;
	Wed,  1 Nov 2023 22:39:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with SMTP id E73D3492BFA;
	Wed,  1 Nov 2023 22:39:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Nov 2023 23:38:28 +0100 (CET)
Date: Wed, 1 Nov 2023 23:38:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101223824.GG32034@redhat.com>
References: <20231101204023.GC32034@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <1959105.1698873750@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1959105.1698873750@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 11/01, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Just none of read_seqbegin_or_lock/need_seqretry/done_seqretry
> > helpers make any sense in this code.
>
> I disagree.  I think in at least a couple of cases I do want a locked second
> path

Sorry for confusion. I never said that the 2nd locked pass makes no sense.

My only point is that rxrpc_find_service_conn_rcu() (and more) use
read_seqbegin_or_lock() incorrectly. They can use read_seqbegin() and this
won't change the current behaviour.

So lets change these users first? Then we can discuss the possible changes
in include/linux/seqlock.h and (perhaps) update the users which actually
want the locking on the 2nd pass.

Oleg.


