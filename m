Return-Path: <netdev+bounces-20484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0995875FBA4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309B82814A0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3FDF6D;
	Mon, 24 Jul 2023 16:16:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592EDF61
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:16:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A510C7
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690215367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvPju9UecviXiaOzgyy4f97iyrnfpdgE7f1YC76j9q8=;
	b=JoMqX5D7F6hBss5jeQawz0VxhR++6mCq25rUrYDTtFnrja+mInhZk5v0Da0jpIHfvYsGiI
	ojXSWtXYTGNQhRR/Qzr/3AKt86pUP8Rk4m/jC1LcGhdChNNZLGdW4yPnncNYbZjbp9a4aL
	l/gLzJNDIHTh7o31ABVfEIK8sIelf10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-91KBanixNt-l4k_5d6stQg-1; Mon, 24 Jul 2023 12:16:03 -0400
X-MC-Unique: 91KBanixNt-l4k_5d6stQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6084E85A58A;
	Mon, 24 Jul 2023 16:16:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 766D8492C13;
	Mon, 24 Jul 2023 16:15:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegstr2CwC2ZL4-y_bAjS3hqF_vta5e4XQneJYmxz9rhVpA@mail.gmail.com>
References: <CAJfpegstr2CwC2ZL4-y_bAjS3hqF_vta5e4XQneJYmxz9rhVpA@mail.gmail.com> <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com> <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com> <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com> <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com> <63041.1690191864@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
    Matthew Wilcox <willy@infradead.org>,
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
Content-ID: <12728.1690215357.1@warthog.procyon.org.uk>
Date: Mon, 24 Jul 2023 17:15:57 +0100
Message-ID: <12729.1690215357@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Both source and destination of copy_file_range() are regular files and

Ah - the check is in generic_file_rw_checks().  Okay, nevermind.  (Though it
looks like it might allow this to be used with procfiles and suchlike, but
anyone who tries that had probably better know what they're doing).

David


