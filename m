Return-Path: <netdev+bounces-13964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FC073E358
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612AD280D4E
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99053BE64;
	Mon, 26 Jun 2023 15:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6CBA49
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:31:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6881722
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687793444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7uLYHxA1BeyjC2zeH9Gn+m3MAcFP9PjLf/sWdMqlqe8=;
	b=Op+dfTjwM+QCIyVLdEGzmP8oLq7IElZYOZ2wBbsVA7urdao1XCXjcp1VVL8BkGfDtqkYrx
	qF8J2f12qQPWjmOS05EzeKxZbtKYRPnBxTGtiSqOIi+ZzD101W7s4n9IszYNkIvbKnuM+M
	AwImM6LtUBvP6gkA9hsJ1EIW+CMZWE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-PqDpqqq7PE2LP5FGnG2VSA-1; Mon, 26 Jun 2023 11:30:42 -0400
X-MC-Unique: PqDpqqq7PE2LP5FGnG2VSA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 228B51044597;
	Mon, 26 Jun 2023 15:30:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 222FE492B01;
	Mon, 26 Jun 2023 15:30:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrRcW1U8pc_BA@mail.gmail.com>
References: <CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrRcW1U8pc_BA@mail.gmail.com> <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-5-dhowells@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
    ceph-devel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/16] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3070988.1687793422.1@warthog.procyon.org.uk>
Date: Mon, 26 Jun 2023 16:30:22 +0100
Message-ID: <3070989.1687793422@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Dryomov <idryomov@gmail.com> wrote:

> write_partial_message_data() is net/ceph/messenger_v1.c specific, so it
> doesn't apply here.  I would suggest squashing the two net/ceph patches
> into one since even the titles are the same.

I would, but they're now applied to net-next, so we need to patch that.

> >   * Write as much as possible.  The socket is expected to be corked,
> > - * so we don't bother with MSG_MORE/MSG_SENDPAGE_NOTLAST here.
> > + * so we don't bother with MSG_MORE here.
> >   *
> >   * Return:
> > - *   1 - done, nothing (else) to write
> > + *  >0 - done, nothing (else) to write
> 
> It would be nice to avoid making tweaks like this to the outer
> interface as part of switching to a new internal API.

Ok.  I'll change that and wrap the sendmsg in a loop.  Though, as I asked in
an earlier reply, why is MSG_DONTWAIT used here?

> > +       if (WARN_ON(!iov_iter_is_bvec(&con->v2.out_iter)))
> > +               return -EINVAL;
> 
> Previously, this WARN_ON + error applied only to the "try sendpage"
> path.  There is a ton of kvec usage in net/ceph/messenger_v2.c, so I'm
> pretty sure that placing it here breaks everything.

This should have been removed as MSG_SPLICE_PAGES now accepts KVEC and XARRAY
iterators also.

Btw, is it feasible to use con->v2.out_iter_sendpage to apply MSG_SPLICE_PAGES
to the iterator to be transmitted as a whole?  It seems to be set depending on
iterator type.

David


