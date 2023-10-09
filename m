Return-Path: <netdev+bounces-39309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D07BEBF1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E60281AC2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EDF1F19D;
	Mon,  9 Oct 2023 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5133E47D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:14 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3292
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:13 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-cwYCUPSZP_a9LsdELoCePQ-1; Mon, 09 Oct 2023 16:51:11 -0400
X-MC-Unique: cwYCUPSZP_a9LsdELoCePQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97EB785A5BE;
	Mon,  9 Oct 2023 20:51:10 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 975A74780;
	Mon,  9 Oct 2023 20:51:09 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 10/14] tls: remove tls_context argument from tls_set_sw_offload
Date: Mon,  9 Oct 2023 22:50:50 +0200
Message-ID: <8aa760076922ebb50ef89cdba611b52ec1456059.1696596130.git.sd@queasysnail.net>
In-Reply-To: <cover.1696596130.git.sd@queasysnail.net>
References: <cover.1696596130.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It's not really needed since we end up refetching it as tls_ctx. We
can also remove the NULL check, since we have already dereferenced ctx
in do_tls_setsockopt_conf.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |  2 +-
 net/tls/tls_device.c |  2 +-
 net/tls/tls_main.c   |  4 ++--
 net/tls/tls_sw.c     | 18 ++++++++----------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 756ed6cbc3df..d9e8cd73b20e 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -146,7 +146,7 @@ int init_prot_info(struct tls_prot_info *prot,
 =09=09   const struct tls_crypto_info *crypto_info,
 =09=09   const struct tls_cipher_desc *cipher_desc,
 =09=09   int mode);
-int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx);
+int tls_set_sw_offload(struct sock *sk, int tx);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 0184426251b0..1dc217870f9d 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1233,7 +1233,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct=
 tls_context *ctx)
 =09context->resync_nh_reset =3D 1;
=20
 =09ctx->priv_ctx_rx =3D context;
-=09rc =3D tls_set_sw_offload(sk, ctx, 0);
+=09rc =3D tls_set_sw_offload(sk, 0);
 =09if (rc)
 =09=09goto release_ctx;
=20
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b91524ac1009..6c5e0cad89e8 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -663,7 +663,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 =09=09} else {
-=09=09=09rc =3D tls_set_sw_offload(sk, ctx, 1);
+=09=09=09rc =3D tls_set_sw_offload(sk, 1);
 =09=09=09if (rc)
 =09=09=09=09goto err_crypto_info;
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
@@ -677,7 +677,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
 =09=09} else {
-=09=09=09rc =3D tls_set_sw_offload(sk, ctx, 0);
+=09=09=09rc =3D tls_set_sw_offload(sk, 0);
 =09=09=09if (rc)
 =09=09=09=09goto err_crypto_info;
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 0995d3d14f4b..0f6da4ce3ed7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2657,24 +2657,22 @@ int init_prot_info(struct tls_prot_info *prot,
 =09return 0;
 }
=20
-int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
+int tls_set_sw_offload(struct sock *sk, int tx)
 {
-=09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
-=09struct tls_prot_info *prot =3D &tls_ctx->prot_info;
-=09struct tls_crypto_info *crypto_info;
 =09struct tls_sw_context_tx *sw_ctx_tx =3D NULL;
 =09struct tls_sw_context_rx *sw_ctx_rx =3D NULL;
+=09const struct tls_cipher_desc *cipher_desc;
+=09struct tls_crypto_info *crypto_info;
+=09char *iv, *rec_seq, *key, *salt;
 =09struct cipher_context *cctx;
+=09struct tls_prot_info *prot;
 =09struct crypto_aead **aead;
+=09struct tls_context *ctx;
 =09struct crypto_tfm *tfm;
-=09char *iv, *rec_seq, *key, *salt;
-=09const struct tls_cipher_desc *cipher_desc;
 =09int rc =3D 0;
=20
-=09if (!ctx) {
-=09=09rc =3D -EINVAL;
-=09=09goto out;
-=09}
+=09ctx =3D tls_get_ctx(sk);
+=09prot =3D &ctx->prot_info;
=20
 =09if (tx) {
 =09=09ctx->priv_ctx_tx =3D init_ctx_tx(ctx, sk);
--=20
2.42.0


