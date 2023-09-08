Return-Path: <netdev+bounces-32602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB95798A41
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89021C20C28
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC511724;
	Fri,  8 Sep 2023 15:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF2F51C
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:56:06 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B121BF5
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:56:05 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-mwC_MfAbOr2feJrqBor9GQ-1; Fri, 08 Sep 2023 11:56:02 -0400
X-MC-Unique: mwC_MfAbOr2feJrqBor9GQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65C2C802E5A;
	Fri,  8 Sep 2023 15:56:01 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E6A493110;
	Fri,  8 Sep 2023 15:56:00 +0000 (UTC)
Date: Fri, 8 Sep 2023 17:55:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, davejwatson@fb.com, kuba@kernel.org,
	vakul.garg@nxp.com, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <ZPtED-ZlSEQmPSlr@hog>
References: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
 <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for looking at this patch. In retrospect I should have cc'd you
on it.

2023-09-08, 14:10:05 +0800, Herbert Xu wrote:
> Sabrina Dubroca <sd@queasysnail.net> wrote:
> > Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> > requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
> > -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> > the cryptd queue for AESNI is full (easy to trigger with an
> > artifically low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> > to the backlog but still processed. In that case, the async callback
> > will also be called twice: first with err =3D=3D -EINPROGRESS, which it
> > seems we can just ignore, then with err =3D=3D 0.
> >=20
> > I've only tested this on AESNI with cryptd.
> >=20
> > Fixes: a54667f6728c ("tls: Add support for encryption using async offlo=
ad accelerator")
> > Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls =
records")
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> > net/tls/tls_sw.c | 23 +++++++++++++++--------
> > 1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> You should only use MAY_BACKLOG if you can actually back off and
> stop issuing new requests.  In that case you can only restart
> issuing new requests when the EINPROGRESS notification comes in.
>=20
> If that's not the case here you should drop MAY_BACKLOG altogether.

Uh, ok, I didn't know that, thanks for explaining. When I was fixing
this code I couldn't find a mention of what the expectations for
MAY_BACKLOG are. Could you add a comment describing this in the
headers (either for #define CRYPTO_TFM_REQ_MAY_BACKLOG or
aead_request_set_callback, wherever is more appropriate). MAY_BACKLOG
is used by both tls and tipc (talking only about networking) and
neither seem to respect this need to back off.

Jakub, I guess we should drop the CRYPTO_TFM_REQ_MAY_BACKLOG for net,
and maybe consider adding it back (with the back off) in
net-next. Probably not urgent considering that nobody seems to have
run into this bug so far.

But then we have to handle ENOSPC a bit more gracefully, because right
now it looks like
 - on TX, we break the socket (tls_err_abort when tls_do_encryption returns
   an error)
 - on RX, we also break the socket, and we don't decrement
   decrypt_pending so the recv() call gets stuck

Not sure how complex the changes would be, the sendmsg and recvmsg
code is already a bit hard to follow.

--=20
Sabrina


