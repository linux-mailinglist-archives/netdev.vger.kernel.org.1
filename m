Return-Path: <netdev+bounces-13305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537F73B33D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4405528193A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20E17FC;
	Fri, 23 Jun 2023 09:08:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27F3D6C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:08:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CDC213A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687511305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t296XX7Ide+MxH8Ui7MMhn8jUrjQ4TRebXX4EzAUHEE=;
	b=Ht3srXnGcB7AIUIVQoQQ4wPDAssC9145kfno3N3pWyWo7YxB4Z+vcJmnDmL0Et6RIEU52w
	NJSGrmDySBWAMkS5b/cVaBth2yIIMyICV/cCTF9nhAeHMU8GpR2HOAWznyfwfc6d+7C2zo
	YQk7Ebs/zLUMWpAoYOzG77aXt5NYJuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-u4jdwn5dMhqzFVv4305B2A-1; Fri, 23 Jun 2023 05:08:22 -0400
X-MC-Unique: u4jdwn5dMhqzFVv4305B2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35F118CC202;
	Fri, 23 Jun 2023 09:08:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80F51492C13;
	Fri, 23 Jun 2023 09:08:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230622191134.54d5cb0b@kernel.org>
References: <20230622191134.54d5cb0b@kernel.org> <20230622132835.3c4e38ea@kernel.org> <20230622111234.23aadd87@kernel.org> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com> <1952674.1687462843@warthog.procyon.org.uk> <1958077.1687474471@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, Eric Dumazet <edumazet@google.com>,
    netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1969747.1687511298.1@warthog.procyon.org.uk>
Date: Fri, 23 Jun 2023 10:08:18 +0100
Message-ID: <1969749.1687511298@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> wrote:

> If we can't reach instant agreement --
> can you strategically separate out the minimal set of changes required
> to just kill MSG_SENDPAGE_NOTLAST. IMHO it's worth getting that into
> 6.5.

Paolo Abeni <pabeni@redhat.com> wrote:

> Given all the above, and the late stage of the current devel cycle,
> would you consider slicing down this series to just kill
> MSG_SENDPAGE_NOTLAST, as Jakub suggested?

I could do that.

There is also another alternative.  I could just push the sendpage wrappers up
the stack into the higher-level callers.  Basically this:

int udp_sendpage(struct sock *sk, struct page *page, int offset,
		 size_t size, int flags)
{
	struct bio_vec bvec;
	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES };

	if (flags & MSG_SENDPAGE_NOTLAST)
		msg.msg_flags |= MSG_MORE;

	bvec_set_page(&bvec, page, size, offset);
	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
	return udp_sendmsg(sk, &msg, size);
}

and kill off sendpage and MSG_SENDPAGE_NOTLAST.

David


