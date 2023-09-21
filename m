Return-Path: <netdev+bounces-35463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46567A99AA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30408B21133
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058319455;
	Thu, 21 Sep 2023 17:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF24446E
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:23:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556775A035
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:21:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-tT6XIwH6NoO3sNNrU8Sykg-1; Thu, 21 Sep 2023 15:05:00 +0100
X-MC-Unique: tT6XIwH6NoO3sNNrU8Sykg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Sep
 2023 15:05:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Sep 2023 15:05:00 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, "Christian
 Brauner" <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, "Jeff
 Layton" <jlayton@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 00/11] iov_iter: Convert the iterator macros into
 inline funcs
Thread-Topic: [PATCH v5 00/11] iov_iter: Convert the iterator macros into
 inline funcs
Thread-Index: AQHZ7BD/kh4zTlIOdEezFNQQd09cYrAlRT1Q
Date: Thu, 21 Sep 2023 14:04:59 +0000
Message-ID: <591a70bf016b4317add2d936696abc0f@AcuMS.aculab.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
In-Reply-To: <20230920222231.686275-1-dhowells@redhat.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Howells
> Sent: 20 September 2023 23:22
...
>  (8) Move the copy-and-csum code to net/ where it can be in proximity wit=
h
>      the code that uses it.  This eliminates the code if CONFIG_NET=3Dn a=
nd
>      allows for the slim possibility of it being inlined.
>=20
>  (9) Fold memcpy_and_csum() in to its two users.
>=20
> (10) Move csum_and_copy_from_iter_full() out of line and merge in
>      csum_and_copy_from_iter() since the former is the only caller of the
>      latter.

I thought that the real idea behind these was to do the checksum
at the same time as the copy to avoid loading the data into the L1
data-cache twice - especially for long buffers.
I wonder how often there are multiple iov[] that actually make
it better than just check summing the linear buffer?

I had a feeling that check summing of udp data was done during
copy_to/from_user, but the code can't be the copy-and-csum here
for that because it is missing support form odd-length buffers.

Intel x86 desktop chips can easily checksum at 8 bytes/clock
(But probably not with the current code!).
(I've got ~12 bytes/clock using adox and adcx but that loop
is entirely horrid and it would need run-time patching.
Especially since I think some AMD cpu execute them very slowly.)

OTOH 'rep movs[bq]' copy will copy 16 bytes/clock (32 if the
destination is 32 byte aligned - it pretty much won't be).

So you'd need a csum-and-copy loop that did 16 bytes every
three clocks to get the same throughput for long buffers.
In principle splitting the 'adc memory' into two instructions
is the same number of u-ops - but I'm sure I've tried to do
that and failed and the extra memory write can happen in
parallel with everything else.
So I don't think you'll get 16 bytes in two clocks - but you
might get it is three.

OTOH for a cpu where memcpy is code loop summing the data in
the copy loop is likely to be a gain.

But I suspect doing the checksum and copy at the same time
got 'all to complicated' to actually implement fully.
With most modern ethernet chips checksumming receive pacakets
does it really get used enough for the additional complexity?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


