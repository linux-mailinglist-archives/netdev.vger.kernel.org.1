Return-Path: <netdev+bounces-14822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39E74401E
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A1C1C20BFA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4B16432;
	Fri, 30 Jun 2023 16:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF0168AD
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 16:50:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21673AAF
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688143851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXsxRCKTcFnH6tZm3WnmJviu/bPYYkz5AVx2X61PXao=;
	b=C2m/dblPj+tCalPFx01QkIw893rbQJptGRyvYEaznDW7/u5+2hsWJxFH8fAJT9a41lf5Y8
	c6JxEdnVXBXw2JVD4johYvmnI26xaKea1F4snC7NZ69je95Krpvkxn0n47irb3zAWCN2jH
	u0CtzQzYaSSPEfy+IEkIfQZNKjhl+D4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-8Km4rewcPI-qX0YsQuwZ8Q-1; Fri, 30 Jun 2023 12:50:45 -0400
X-MC-Unique: 8Km4rewcPI-qX0YsQuwZ8Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4594E3813F2A;
	Fri, 30 Jun 2023 16:50:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED3D4CD0C2;
	Fri, 30 Jun 2023 16:50:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6obkzr3qXXbYA@mail.gmail.com>
References: <CAHk-=wjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6obkzr3qXXbYA@mail.gmail.com> <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com> <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name> <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com> <ZJ3OoCcSxZzzgUur@casper.infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Matt Whitlock <kernel@mattwhitlock.name>, netdev@vger.kernel.org,
    Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
    linux-fsdevel@kvack.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <663488.1688143843.1@warthog.procyon.org.uk>
Date: Fri, 30 Jun 2023 17:50:43 +0100
Message-ID: <663489.1688143843@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Quite the reverse. I'd be willing to *simplify* splice() by just
> saying "it was all a mistake", and just turning it into wrappers
> around read/write. But those patches would have to be radical
> simplifications, not adding yet more crud on top of the pain that is
> splice().
> 
> Because it will hurt performance. And I'm ok with that as long as it
> comes with huge simplifications. What I'm *not* ok with is "I mis-used
> splice, now I want splice to act differently, so let's make it even
> more complicated".

If we want to go down the simplification route, then the patches I posted
might be a good start.

The idea I tried to work towards is that the pipe only ever contains private
pages in it that only the pipe has a ref on and that no one else can access
until they come out the other end again.  I got rid of the ->confirm() pipe
buf op and would like to kill off all of the others too.

I simplified splice() by:

 - Making sure any candidate pages are uptodate right up front.

 - Allowing automatic stealing of pages from the pagecache if no one else is
   using them.  This should avoid losing a chunk of the performance that
   splice is supposed to gain - but if you're serving pages repeatedly in a
   webserver with this, it's going to be a problem.

   Possibly this should be contingent on SPLICE_F_MOVE - though the manpage
   says "*from* the pipe" implying it's only usable on the output side.

 - Copying in every other circumstance.

I simplified vmsplice() by:

 - If SPLICE_F_GIFT is set, attempting to steal whole pages in the buffer up
   front if not in use by anyone else.

 - Copying in every other circumstance.

That said, there are still sources that I didn't touch yet that attempt to
insert pages into a pipe: relayfs (which does some accounting stuff based on
the final consumption of the pages it inserted), sockets (which don't allow
inserted pages to be stolen) and notifications (which don't want to allocate
at notification time - but I can deal with that).  And there's tee() (which
would need to copy the data).  And pipe-to-pipe splice (which could steal
whole pages, but would otherwise have to copy).


If you would prefer to go for utter simplification, we could make sendfile()
from a buffered file just call sendmsg() directly with MSG_SPLICE_PAGES set
and ignore the pipe entirely (I'm tempted to do this anyway) and then make
splice() to a pipe just do copy_splice_read() and vmsplice() to a pipe do
writev().

I wonder how much splice() is used compared to sendfile().


I would prefer to leave splice() and vmsplice() as they are now and adjust the
documentation.  As you say, they can be considered a type of zerocopy.

David


