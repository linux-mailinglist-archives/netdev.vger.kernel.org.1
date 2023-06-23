Return-Path: <netdev+bounces-13321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99873B44A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA816281A0E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEBE525D;
	Fri, 23 Jun 2023 10:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE54524F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:00:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67215D3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687514437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP4AKCOOCr3pvthAQvIZ1/UuuvTX3OWbks29gUYE0Ps=;
	b=FUZCo9T3Rwic2OkgrUn2TBo1miuiWt042lcxrhSJuJWk3Tqw7x2j/ohodmyMymPOwV7P1a
	joLTwpXztaye0qg2rZ8nmANR8LQHLK8qVl9WFoC/nyXINfWOkVlZLF8tPWvpEOl3e8umqN
	ydRhHNYcNJ/oaPnke9JB2uyUWW34vV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-SIClFxpKM26PS55qx0QLEw-1; Fri, 23 Jun 2023 06:00:33 -0400
X-MC-Unique: SIClFxpKM26PS55qx0QLEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4A278CC202;
	Fri, 23 Jun 2023 10:00:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ADE904087C6D;
	Fri, 23 Jun 2023 10:00:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6cf2ea121c4fdbd04682224c5acf6c73cc47f2f7.camel@redhat.com>
References: <6cf2ea121c4fdbd04682224c5acf6c73cc47f2f7.camel@redhat.com> <634c885ccfb2e49e284aedc60e157bb12e5f3530.camel@redhat.com> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com> <1969720.1687511219@warthog.procyon.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jun 2023 11:00:26 +0100
Message-ID: <2048396.1687514426@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni <pabeni@redhat.com> wrote:

> > Maybe.  I was trying to put the fast path up at the top without the slo=
w path
> > bits in it, but I can put the "insufficient_space" bit there.
>=20
> I *think* you could move the insufficient_space in a separate helped,
> that should achieve your goal with fewer labels and hopefully no
> additional complexity.

It would require moving things in and out of variables more, but that's
probably fine in the slow path.  The code I derived this from seems to do i=
ts
best only to touch memory when it absolutely has to.  But doing what you
suggest would certainly make this more readable, I think.

> > > What if fragsz > PAGE_SIZE, we are consistently unable to allocate an
> > > high order page, but order-0, pfmemalloc-ed page allocation is
> > > successful? It looks like this could become an unbounded loop?
> >=20
> > It shouldn't.  It should go:
> >=20
> > 	try_again:
> > 		if (fragsz > offset)
> > 			goto insufficient_space;
> > 	insufficient_space:
> > 		/* See if we can refurbish the current folio. */
> > 		...
>=20
> I think the critical path is with pfmemalloc-ed pages:
>=20
> 		if (unlikely(cache->pfmemalloc)) {
> 			__folio_put(folio);
> 			goto get_new_folio;
> 		}

I see what you're getting at.  I was thinking that you meant that the criti=
cal
bit was that we got into a loop because we never managed to allocate a folio
big enough.

Inserting a check in the event that we fail to allocate an order-3 folio wo=
uld
take care of that, I think.  After that point, we have a spare folio of
sufficient capacity, even if the folio currently in residence is marked
pfmemalloc.

> > > will go through that for every page, even if the expected use-case is
> > > always !PageSlub(page). compound_head() could be costly if the head
> > > page is not hot on cache and I'm not sure if that could be the case f=
or
> > > tcp 0-copy. The bottom line is that I fear a possible regression here.
> >=20
> > I can put the PageSlab() check inside the sendpage_ok() so the page fla=
g is
> > only checked once. =C2=A0
>=20
> Perhaps I'm lost again, but AFAICS:
>=20
> __PAGEFLAG(Slab, slab, PF_NO_TAIL)
> ...
>                 PF_POISONED_CHECK(compound_head(page)); })
>=20
> It looks at compound_head in the end ?!?

Fair point.  Those macros are somewhat hard to read.  Hopefully, all the
compound_head() calls will go away soon-ish.


