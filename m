Return-Path: <netdev+bounces-32297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4F794010
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB7B2812BA
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A3107AE;
	Wed,  6 Sep 2023 15:14:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE94101C6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 15:14:52 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A763E64
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 08:14:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-qCBHT5ciOGC6lOfqkJ9htw-1; Wed, 06 Sep 2023 11:14:45 -0400
X-MC-Unique: qCBHT5ciOGC6lOfqkJ9htw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2695C10487A0;
	Wed,  6 Sep 2023 15:14:45 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 848CD412F2CF;
	Wed,  6 Sep 2023 15:14:43 +0000 (UTC)
Date: Wed, 6 Sep 2023 17:14:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Liu Jian <liujian56@huawei.com>, borisp@nvidia.com,
	john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vfedorenko@novek.ru, netdev@vger.kernel.org
Subject: Re: [PATCH net] tls: do not return error when the tls_bigint
 overflows in tls_advance_record_sn()
Message-ID: <ZPiXYkYewO1Z7WRN@hog>
References: <20230906065237.2180187-1-liujian56@huawei.com>
 <ZPhcTQ3mFQYmTHet@hog>
 <20230906080231.18d99950@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230906080231.18d99950@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

2023-09-06, 08:02:31 -0700, Jakub Kicinski wrote:
> On Wed, 6 Sep 2023 13:02:37 +0200 Sabrina Dubroca wrote:
> > I've been running the selftests with async crypto and have collected a
> > few fixes that I was going to post this week (but not this one, since
> > we don't have a selftest for wrapping rec_seq). One of the patches
> > adds -EBUSY checks for all existing -EINPROGRESS, since the crypto API
> > can return -EBUSY as well if we're going through the backlog queue.
>=20
> BTW is it possible to fake async crypto for a test or does one need=20
> to have an actual accelerator?

That's what I did for my tests, forcing AESNI to go async. I'm going
to send my changes as RFC to linux-crypto@. I think syzbot would find
a few more bugs if they let it loose with forced async crypto.

Short version (without the debugfs toggles):

diff --git a/crypto/simd.c b/crypto/simd.c
index edaa479a1ec5..e3f3bf31fcca 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -317,7 +317,7 @@ static int simd_aead_encrypt(struct aead_request *req)
 =09subreq =3D aead_request_ctx(req);
 =09*subreq =3D *req;
=20
-=09if (!crypto_simd_usable() ||
+=09if (true /* force async */ || !crypto_simd_usable() ||
 =09    (in_atomic() && cryptd_aead_queued(ctx->cryptd_tfm)))
 =09=09child =3D &ctx->cryptd_tfm->base;
 =09else
@@ -338,7 +338,7 @@ static int simd_aead_decrypt(struct aead_request *req)
 =09subreq =3D aead_request_ctx(req);
 =09*subreq =3D *req;
=20
-=09if (!crypto_simd_usable() ||
+=09if (true /* force async */ || !crypto_simd_usable() ||
 =09    (in_atomic() && cryptd_aead_queued(ctx->cryptd_tfm)))
 =09=09child =3D &ctx->cryptd_tfm->base;
 =09else


--=20
Sabrina


