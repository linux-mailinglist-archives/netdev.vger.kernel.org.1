Return-Path: <netdev+bounces-20290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BD75EF60
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93EF1C209BC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2E6FD3;
	Mon, 24 Jul 2023 09:44:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1756185A
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:44:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E01B2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690191871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcc0VwYrlT1E7PEgvFDL6PneMWy9XGB7K8wngN/IhDY=;
	b=UUtOQjkUPPCrL+16AX2FWjWs5aRm1kx9iGWa5UnEbpJpk08fCkC7ARh7GR0ne8SEuvwGs6
	WaJEOLuVuxg68UiW2SO4FpU095lWqDd8NVVbW5C/1Jtqnt2tzYuHssFGlnm6FAAzFr+dxU
	IYgwG46lKX1tiMKlxCvNBU0fed+HUN8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-zUuadyWlPVCQ0U_JCQHkbQ-1; Mon, 24 Jul 2023 05:44:27 -0400
X-MC-Unique: zUuadyWlPVCQ0U_JCQHkbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E1493806703;
	Mon, 24 Jul 2023 09:44:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 734FE1121315;
	Mon, 24 Jul 2023 09:44:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
References: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com> <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com> <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com> <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com> <ZLg9HbhOVnLk1ogA@casper.infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Miklos Szeredi <miklos@szeredi.hu>,
    Matt Whitlock <kernel@mattwhitlock.name>, netdev@vger.kernel.org,
    Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
    linux-fsdevel@kvack.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
    linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after splice() returns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63040.1690191864.1@warthog.procyon.org.uk>
Date: Mon, 24 Jul 2023 10:44:24 +0100
Message-ID: <63041.1690191864@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > So what's the API that provides the semantics of _copying_?
> 
> It's called "read()" and "write()".

What about copy_file_range()?  That seems to fall back to splicing if not
directly implemented by the filesystem.  It looks like the manpage for that
needs updating too - or should that actually copy?

David


