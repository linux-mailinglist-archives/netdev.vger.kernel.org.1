Return-Path: <netdev+bounces-48337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5297EE1B6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A3C1F240B2
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526572D61E;
	Thu, 16 Nov 2023 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW4yNKHA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9088B4
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700142113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IxptJPCrY+QSm5n5VLsWoPBouQFJKh6ohstDe/UHPEk=;
	b=OW4yNKHA7etCwlWD6+FoM9U6iDT5s3/JyxfX8jPmSCT5/6GBXHOYjthEXM8D14bmLr9JZF
	DNNHT/b7wrr+/ZBB3TwiaaCLs8vMMsNu5mGDa4QJIwHa0P49fuDTugzyJczcv407d/rPQR
	yZo1pmr3wt87lL8IiplrPq3tBm3nhm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-DSrWWSYgNWKVgZrx_9hZYA-1; Thu,
 16 Nov 2023 08:41:50 -0500
X-MC-Unique: DSrWWSYgNWKVgZrx_9hZYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AF651C06518;
	Thu, 16 Nov 2023 13:41:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9904910EA1;
	Thu, 16 Nov 2023 13:41:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231116131849.GA27763@redhat.com>
References: <20231116131849.GA27763@redhat.com> <20231027095842.GA30868@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
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
Content-ID: <104931.1700142106.1@warthog.procyon.org.uk>
Date: Thu, 16 Nov 2023 13:41:46 +0000
Message-ID: <104932.1700142106@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Oleg Nesterov <oleg@redhat.com> wrote:

> So do you agree that
> 
> 	- the usage of read_seqbegin_or_lock/need_seqretry in
> 	  this code makes no sense because read_seqlock_excl()
> 	  is not possible

Not exactly.  I think it should take a lock on the second pass.

> 	- this patch doesn't change the current behaviour but
> 	  simplifies the code and makes it more clear

That is true.

David


