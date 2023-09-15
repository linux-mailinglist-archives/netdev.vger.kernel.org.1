Return-Path: <netdev+bounces-34060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9357A1E75
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32098282519
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C564D10795;
	Fri, 15 Sep 2023 12:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E10DDDE
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:20:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2412273D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694780393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6YdaabWMt5kMqbNYNBaQroIwASFlYwE8xKBnDy2tD0=;
	b=fevduDTFgbcoGGopeKCknX3zxHY3ujh6xDv6jcCGr5PPyP99AbDynyEr/qQYLQP9jsuySN
	pKCQUUjnRN2O8JYtiUUbTPe8i2Gw7cxVCTCcdZApKj9Lr3VMXt5iMgvBVGBvYOvUwVDRhA
	AR/Qum3srKnZ1/UBQ7UNxVeiXoAURcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-7G8sFEHCP9WrzceNBoHclg-1; Fri, 15 Sep 2023 08:19:49 -0400
X-MC-Unique: 7G8sFEHCP9WrzceNBoHclg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEA2E857F8A;
	Fri, 15 Sep 2023 12:19:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B0591004145;
	Fri, 15 Sep 2023 12:19:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com>
References: <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com> <20230914221526.3153402-1-dhowells@redhat.com> <20230914221526.3153402-10-dhowells@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
    "Christian
 Brauner" <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    "Brendan Higgins" <brendanhiggins@google.com>,
    David Gow <davidgow@google.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "linux-mm@kvack.org" <linux-mm@kvack.org>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
    "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Christian Brauner <brauner@kernel.org>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3545839.1694780385.1@warthog.procyon.org.uk>
Date: Fri, 15 Sep 2023 13:19:45 +0100
Message-ID: <3545840.1694780385@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Laight <David.Laight@ACULAB.COM> wrote:

> Isn't that going to be completely dominated by the cache fills
> from memory?
> 
> I'd have thought you'd need to use something with a lot of
> small fragments so that the iteration code dominates the copy.

Okay, if I switch it to using MAP_ANON for the big 256MiB buffer, switch all
the benchmarking tests to use copy_from_iter() rather than copy_to_iter() and
make the iovec benchmark use a separate iovec for each page, there's then a
single page replicated across the mapping.

Given that, without my macro-to-inline-func patches applied, I see:

	iov_kunit_benchmark_bvec: avg 3184 uS, stddev 16 uS
	iov_kunit_benchmark_bvec: avg 3189 uS, stddev 17 uS
	iov_kunit_benchmark_bvec: avg 3190 uS, stddev 16 uS
	iov_kunit_benchmark_bvec_outofline: avg 3731 uS, stddev 10 uS
	iov_kunit_benchmark_bvec_outofline: avg 3735 uS, stddev 10 uS
	iov_kunit_benchmark_bvec_outofline: avg 3738 uS, stddev 11 uS
	iov_kunit_benchmark_bvec_split: avg 3403 uS, stddev 10 uS
	iov_kunit_benchmark_bvec_split: avg 3405 uS, stddev 18 uS
	iov_kunit_benchmark_bvec_split: avg 3407 uS, stddev 29 uS
	iov_kunit_benchmark_iovec: avg 6616 uS, stddev 20 uS
	iov_kunit_benchmark_iovec: avg 6619 uS, stddev 22 uS
	iov_kunit_benchmark_iovec: avg 6621 uS, stddev 46 uS
	iov_kunit_benchmark_kvec: avg 2671 uS, stddev 12 uS
	iov_kunit_benchmark_kvec: avg 2671 uS, stddev 13 uS
	iov_kunit_benchmark_kvec: avg 2675 uS, stddev 12 uS
	iov_kunit_benchmark_ubuf: avg 6191 uS, stddev 1946 uS
	iov_kunit_benchmark_ubuf: avg 6418 uS, stddev 3263 uS
	iov_kunit_benchmark_ubuf: avg 6443 uS, stddev 3275 uS
	iov_kunit_benchmark_xarray: avg 3689 uS, stddev 5 uS
	iov_kunit_benchmark_xarray: avg 3689 uS, stddev 6 uS
	iov_kunit_benchmark_xarray: avg 3698 uS, stddev 22 uS
	iov_kunit_benchmark_xarray_outofline: avg 4202 uS, stddev 3 uS
	iov_kunit_benchmark_xarray_outofline: avg 4204 uS, stddev 9 uS
	iov_kunit_benchmark_xarray_outofline: avg 4210 uS, stddev 9 uS

and with, I get:

	iov_kunit_benchmark_bvec: avg 3241 uS, stddev 13 uS
	iov_kunit_benchmark_bvec: avg 3245 uS, stddev 16 uS
	iov_kunit_benchmark_bvec: avg 3248 uS, stddev 15 uS
	iov_kunit_benchmark_bvec_outofline: avg 3705 uS, stddev 12 uS
	iov_kunit_benchmark_bvec_outofline: avg 3706 uS, stddev 10 uS
	iov_kunit_benchmark_bvec_outofline: avg 3709 uS, stddev 9 uS
	iov_kunit_benchmark_bvec_split: avg 3446 uS, stddev 10 uS
	iov_kunit_benchmark_bvec_split: avg 3447 uS, stddev 12 uS
	iov_kunit_benchmark_bvec_split: avg 3448 uS, stddev 12 uS
	iov_kunit_benchmark_iovec: avg 6587 uS, stddev 22 uS
	iov_kunit_benchmark_iovec: avg 6587 uS, stddev 22 uS
	iov_kunit_benchmark_iovec: avg 6590 uS, stddev 27 uS
	iov_kunit_benchmark_kvec: avg 2671 uS, stddev 12 uS
	iov_kunit_benchmark_kvec: avg 2672 uS, stddev 12 uS
	iov_kunit_benchmark_kvec: avg 2676 uS, stddev 19 uS
	iov_kunit_benchmark_ubuf: avg 6241 uS, stddev 2199 uS
	iov_kunit_benchmark_ubuf: avg 6266 uS, stddev 2245 uS
	iov_kunit_benchmark_ubuf: avg 6513 uS, stddev 3899 uS
	iov_kunit_benchmark_xarray: avg 3695 uS, stddev 6 uS
	iov_kunit_benchmark_xarray: avg 3695 uS, stddev 7 uS
	iov_kunit_benchmark_xarray: avg 3703 uS, stddev 11 uS
	iov_kunit_benchmark_xarray_outofline: avg 4215 uS, stddev 16 uS
	iov_kunit_benchmark_xarray_outofline: avg 4217 uS, stddev 20 uS
	iov_kunit_benchmark_xarray_outofline: avg 4224 uS, stddev 10 uS

Interestingly, most of them are quite tight, but UBUF is all over the place.
That's with the test covering the entire 256M span with a single UBUF
iterator, so it would seem unlikely that the difference is due to the
iteration framework.

David


