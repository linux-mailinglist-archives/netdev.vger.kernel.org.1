Return-Path: <netdev+bounces-33287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E191079D518
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBF8281E07
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15ED18C17;
	Tue, 12 Sep 2023 15:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3445179A0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:38:03 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD29B10DE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:38:02 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-8eI8kRsuPQWvNIVeAh8R-w-1; Tue, 12 Sep 2023 11:37:28 -0400
X-MC-Unique: 8eI8kRsuPQWvNIVeAh8R-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C68FF101A529;
	Tue, 12 Sep 2023 15:37:26 +0000 (UTC)
Received: from hog (unknown [10.39.192.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC0582156721;
	Tue, 12 Sep 2023 15:37:25 +0000 (UTC)
Date: Tue, 12 Sep 2023 17:37:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, davejwatson@fb.com, kuba@kernel.org,
	vakul.garg@nxp.com, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <ZQCFs61yeFlYsHVX@hog>
References: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
 <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
 <ZPtED-ZlSEQmPSlr@hog>
 <ZP/sdGHy7LVE3UEc@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZP/sdGHy7LVE3UEc@gondor.apana.org.au>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-09-12, 12:43:32 +0800, Herbert Xu wrote:
> On Fri, Sep 08, 2023 at 05:55:59PM +0200, Sabrina Dubroca wrote:
> >
> > Uh, ok, I didn't know that, thanks for explaining. When I was fixing
> > this code I couldn't find a mention of what the expectations for
> > MAY_BACKLOG are. Could you add a comment describing this in the
> > headers (either for #define CRYPTO_TFM_REQ_MAY_BACKLOG or
> > aead_request_set_callback, wherever is more appropriate). MAY_BACKLOG
> > is used by both tls and tipc (talking only about networking) and
> > neither seem to respect this need to back off.
>=20
> Patches are welcome :)

Ok. I thought it'd be better if you wrote that patch since if I write
it, it'll be a c/p (or rephrase) of what you wrote. But fine, I'll go
ahead and do that :)

> A bit of history: at the beginning we always dropped requests
> that we couldn't queue because the only user was IPsec so this
> is the expected behaviour.
>=20
> When storage crypto support was added there was a need for reliable
> handling of resource constraints so that's why MAY_BACKLOG was added.
> However, the expectation is obviously that you must stop sending new
> requests once you run into the resource constraint.
>=20
> > Jakub, I guess we should drop the CRYPTO_TFM_REQ_MAY_BACKLOG for net,
> > and maybe consider adding it back (with the back off) in
> > net-next. Probably not urgent considering that nobody seems to have
> > run into this bug so far.
>=20
> I think that would be the prudent action.

We'd have to do pretty much what Jakub suggested [1] (handle ENOSPC by
waiting for all current requests) and then resubmit the failed
request. So I think keeping the MAY_BACKLOG flag and handling EBUSY
this way is simpler. With this, we send one request to the backlog,
then we wait until the queue drains.

[1] https://lore.kernel.org/netdev/20230908142602.2ced0631@kernel.org/

--=20
Sabrina


