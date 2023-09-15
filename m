Return-Path: <netdev+bounces-34046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025A7A1CCE
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DB5282138
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83648FC1D;
	Fri, 15 Sep 2023 10:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F12F5A
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:52:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6822EE71
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:51:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-225-CvPY7ioKPtWKGGdbPunc0A-1; Fri, 15 Sep 2023 11:51:40 +0100
X-MC-Unique: CvPY7ioKPtWKGGdbPunc0A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Sep
 2023 11:51:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 15 Sep 2023 11:51:36 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>
CC: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
	<torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Christian Brauner <christian@brauner.io>, "Matthew
 Wilcox" <willy@infradead.org>, Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>
Subject: RE: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for
 UBUF/IOVEC
Thread-Topic: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for
 UBUF/IOVEC
Thread-Index: AQHZ51kQ26Nrcgq1TkqWWiI5nPv6dLAbdkPggAAj+YCAABqPYA==
Date: Fri, 15 Sep 2023 10:51:36 +0000
Message-ID: <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com>
References: <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com>
 <20230914221526.3153402-1-dhowells@redhat.com>
 <20230914221526.3153402-10-dhowells@redhat.com>
 <3370515.1694772627@warthog.procyon.org.uk>
In-Reply-To: <3370515.1694772627@warthog.procyon.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Howells
> Sent: 15 September 2023 11:10
>=20
> David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > > Add kunit tests to benchmark 256MiB copies to a UBUF iterator and an =
IOVEC
> > > iterator.  This attaches a userspace VM with a mapped file in it
> > > temporarily to the test thread.
> >
> > Isn't that going to be completely dominated by the cache fills
> > from memory?
>=20
> Yes...  but it should be consistent in the amount of time that consumes s=
ince
> no device drivers are involved.  I can try adding the same folio to the
> anon_file multiple times - it might work especially if I don't put the pa=
ges
> on the LRU (if that's even possible) - but I wanted separate pages for th=
e
> extraction test.

You could also just not do the copy!
Although you need (say) asm volatile("\n",:::"memory") to
stop it all being completely optimised away.
That might show up a difference in the 'out_of_line' test
where 15% on top on the data copies is massive - it may be
that the data cache behaviour is very different for the
two cases.

...
> > Some measurements can be made using readv() and writev()
> > on /dev/zero and /dev/null.
>=20
> Forget /dev/null; that doesn't actually engage any iteration code.  The s=
ame
> for writing to /dev/zero.  Reading from /dev/zero does its own iteration =
thing
> rather than using iterate_and_advance(), presumably because it checks for
> signals and resched.

Using /dev/null does exercise the 'copy iov from user' code.
Last time I looked at that the 32bit compat code was faster than
the 64bit code on x86!

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


