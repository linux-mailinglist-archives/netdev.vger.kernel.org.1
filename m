Return-Path: <netdev+bounces-32403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B76797491
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BD281731
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B59012B78;
	Thu,  7 Sep 2023 15:40:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D229B4
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:40:03 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0A26B2
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:39:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-h97T8BI5Pq69vsJa3vL-vg-1; Thu, 07 Sep 2023 08:22:01 -0400
X-MC-Unique: h97T8BI5Pq69vsJa3vL-vg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60E88800888;
	Thu,  7 Sep 2023 12:22:01 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41167404119;
	Thu,  7 Sep 2023 12:22:00 +0000 (UTC)
Date: Thu, 7 Sep 2023 14:21:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
	Vakul Garg <vakul.garg@nxp.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <ZPm__x5TcsmqagBH@hog>
References: <cover.1694018970.git.sd@queasysnail.net>
 <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
 <20230906204727.08a79e00@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230906204727.08a79e00@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-06, 20:47:27 -0700, Jakub Kicinski wrote:
> On Wed,  6 Sep 2023 19:08:35 +0200 Sabrina Dubroca wrote:
> > If the next record is of a different type, we won't copy it to
> > userspace in this round, tls_record_content_type will stop us just
> > after decryption. Skip decryption until the next recvmsg() call.
> >=20
> > This fixes a use-after-free when a data record is decrypted
> > asynchronously but doesn't fill the userspace buffer, and the next
> > record is non-data, for example in the bad_cmsg selftest.
>=20
> What's the UAF on?

It doesn't always happen unless I set cryptd_delay_ms from my debug
patch (10 is enough):
https://patchwork.kernel.org/project/linux-crypto/patch/9d664093b1bf7f47497=
b2c40b3a085b45f3274a2.1694021240.git.sd@queasysnail.net/

UAF is on the crypto_async_request (part of the aead_request,
allocated in the big kmalloc in tls_decrypt_sg), mostly caught when
cryptd_queue_worker calls crypto_request_complete, but sometimes a bit
earlier (in crypto_dequeue_request).

I'll admit this patch is papering over the issue a bit, but decrypting
a record we know we won't read within this recv() call seems a bit
pointless.


I wonder if the way we're using ctx->async_wait here is correct. I'm
observing crypto_wait_req return 0 even though the decryption hasn't
run yet (and it should return -EBADMSG, not 0). I guess
tls_decrypt_done calls the completion (since we only had one
decrypt_pending), and then crypto_wait_req thinks everything is
already done.

Adding a fresh crypto_wait in tls_do_decryption (DECLARE_CRYPTO_WAIT)
and using it in the !darg->async case also seems to fix the UAF (but
makes the bad_cmsg test case fail in the same way as what I wrote in
the cover letter for bad_in_large_read -- not decrypting the next
message at all makes the selftest pass).

Herbert, WDYT? We're calling tls_do_decryption twice from the same
tls_sw_recvmsg invocation, first with darg->async =3D true, then with
darg->async =3D false. Is it ok to use ctx->async_wait for both, or do
we need a fresh one as in this patch?

-------- 8< --------
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 86b835b15872..ad51960f2864 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -246,6 +246,7 @@ static int tls_do_decryption(struct sock *sk,
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
 =09struct tls_prot_info *prot =3D &tls_ctx->prot_info;
 =09struct tls_sw_context_rx *ctx =3D tls_sw_ctx_rx(tls_ctx);
+=09DECLARE_CRYPTO_WAIT(wait);
 =09int ret;
=20
 =09aead_request_set_tfm(aead_req, ctx->aead_recv);
@@ -262,7 +263,7 @@ static int tls_do_decryption(struct sock *sk,
 =09} else {
 =09=09aead_request_set_callback(aead_req,
 =09=09=09=09=09  CRYPTO_TFM_REQ_MAY_BACKLOG,
-=09=09=09=09=09  crypto_req_done, &ctx->async_wait);
+=09=09=09=09=09  crypto_req_done, &wait);
 =09}
=20
 =09ret =3D crypto_aead_decrypt(aead_req);
@@ -270,7 +271,7 @@ static int tls_do_decryption(struct sock *sk,
 =09=09if (darg->async)
 =09=09=09return 0;
=20
-=09=09ret =3D crypto_wait_req(ret, &ctx->async_wait);
+=09=09ret =3D crypto_wait_req(ret, &wait);
 =09}
 =09darg->async =3D false;
=20
--=20
Sabrina


