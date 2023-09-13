Return-Path: <netdev+bounces-33560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A679E92B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC3281CF0
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2471A723;
	Wed, 13 Sep 2023 13:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94AC12D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 13:25:39 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C81419B1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:25:39 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-Gg-XSb25MxqsxVA-DPfu5w-1; Wed, 13 Sep 2023 09:25:33 -0400
X-MC-Unique: Gg-XSb25MxqsxVA-DPfu5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EE5C889047;
	Wed, 13 Sep 2023 13:25:32 +0000 (UTC)
Received: from hog (unknown [10.39.192.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AEA210F1BE7;
	Wed, 13 Sep 2023 13:25:30 +0000 (UTC)
Date: Wed, 13 Sep 2023 15:25:29 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <ZQG4SXGaJpCtWX_k@hog>
References: <cover.1694018970.git.sd@queasysnail.net>
 <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
 <20230906204727.08a79e00@kernel.org>
 <ZPm__x5TcsmqagBH@hog>
 <ZPq51KxgmELpTgOs@gondor.apana.org.au>
 <ZPtACbUa9rQz0uFq@hog>
 <ZP/rS+NtSbJ3EuWc@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZP/rS+NtSbJ3EuWc@gondor.apana.org.au>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-09-12, 12:38:35 +0800, Herbert Xu wrote:
> On Fri, Sep 08, 2023 at 05:38:49PM +0200, Sabrina Dubroca wrote:
> >
> > tls_decrypt_done only runs the completion when decrypt_pending drops
> > to 0, so this should be covered.
>=20
> That doesn't look very safe.  What if the first decrypt completes
> before the second decrypt even starts? Wouldn't that cause two
> complete calls on ctx->async_wait?
>=20
> > I wonder if this situation could happen:
> >=20
> > tls_sw_recvmsg
> >   process first record
> >     decrypt_pending =3D 1
> >                                   CB runs
> >                                   decrypt_pending =3D 0
> >                                   complete(&ctx->async_wait.completion)=
;
> >=20
> >   process second record
> >     decrypt_pending =3D 1
> >   tls_sw_recvmsg reaches "recv_end"
> >     decrypt_pending !=3D 0
> >     crypto_wait_req sees the first completion of ctx->async_wait and pr=
oceeds
> >=20
> >                                   CB runs
> >                                   decrypt_pending =3D 0
> >                                   complete(&ctx->async_wait.completion)=
;
>=20
> Yes that's exactly what I was thinking of.
>=20
> I think this whole thing needs some rethinking and rewriting.

I'm not sure there's a problem.

In tls_sw_recvmsg, the code waiting for async decrypts does:

=09/* Wait for all previously submitted records to be decrypted */
=09spin_lock_bh(&ctx->decrypt_compl_lock);
=09reinit_completion(&ctx->async_wait.completion);
=09pending =3D atomic_read(&ctx->decrypt_pending);
=09spin_unlock_bh(&ctx->decrypt_compl_lock);
=09ret =3D 0;
=09if (pending)
=09=09ret =3D crypto_wait_req(-EINPROGRESS, &ctx->async_wait);


And the async callback finishes with:

=09spin_lock_bh(&ctx->decrypt_compl_lock);
=09if (!atomic_dec_return(&ctx->decrypt_pending))
=09=09complete(&ctx->async_wait.completion);
=09spin_unlock_bh(&ctx->decrypt_compl_lock);


Since we have the reinit_completion call, we'll ignore the previous
complete() (for the first record), and still wait for the 2nd record's
completion.

Does that still look unsafe to you?

--=20
Sabrina


