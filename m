Return-Path: <netdev+bounces-14009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462E73E5F2
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7522B1C209C0
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BAC11CAC;
	Mon, 26 Jun 2023 17:02:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540379448
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:02:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F894E75
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687798976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=azOY5W4L6nPVgicb+nbIq/BbpsGompjeN183hF2U7To=;
	b=cea7Ci+zq6HazhJveGzHTdT3gdapp+ax0LwCeEmAHEv8sXu2HFYpUX2i3AlguxkAiLydw0
	mp+2LYrypXriD1Ti96TJe4FdJHV26deF6Y3x2svF2Rq8NRkEWtUwwJbeeQpFAijtOVbds8
	m1Vx01u03cfjk8o4n0rJRcMWyk392tQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-zM48uT60MEq4-n3KstdqXA-1; Mon, 26 Jun 2023 13:02:52 -0400
X-MC-Unique: zM48uT60MEq4-n3KstdqXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22682800962;
	Mon, 26 Jun 2023 17:01:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 681B140C2063;
	Mon, 26 Jun 2023 17:01:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP9hOhaAWp6ext=6tH7XjKUFAkC0xhkB91QozWr0-fw0NA@mail.gmail.com>
References: <CAOi1vP9hOhaAWp6ext=6tH7XjKUFAkC0xhkB91QozWr0-fw0NA@mail.gmail.com> <20230623225513.2732256-1-dhowells@redhat.com> <20230623225513.2732256-5-dhowells@redhat.com> <CAOi1vP_Bn918j24S94MuGyn+Gxk212btw7yWeDrRcW1U8pc_BA@mail.gmail.com> <3070989.1687793422@warthog.procyon.org.uk>
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
Content-ID: <3085214.1687798916.1@warthog.procyon.org.uk>
Date: Mon, 26 Jun 2023 18:01:56 +0100
Message-ID: <3085215.1687798916@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Dryomov <idryomov@gmail.com> wrote:

> > Btw, is it feasible to use con->v2.out_iter_sendpage to apply
> > MSG_SPLICE_PAGES to the iterator to be transmitted as a whole?  It seems
> > to be set depending on iterator type.
> 
> I'm not sure I understand what you mean by "transmitted as a whole".
> con->v2.out_iter_sendpage is set only when zerocopy is desired.  If the
> underlying data is not guaranteed to remain stable, zerocopy behavior
> is not safe.

I think I need to reinstate the per-page sendpage_ok() check here also -
though Al pointed out it isn't sufficiently exhaustive.  There are pages that
sendpage_ok() will return true on that you shouldn't be passing to sendpage().

I'll whip up a patch to partially revert this also.

David


