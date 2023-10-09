Return-Path: <netdev+bounces-39317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5227BEBF8
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43033281BEC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77621405E6;
	Mon,  9 Oct 2023 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F621F19D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:34 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB00A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:30 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-h6KTtj3INYa1r92z76EuSQ-1; Mon, 09 Oct 2023 16:51:07 -0400
X-MC-Unique: h6KTtj3INYa1r92z76EuSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C153E3C025B2;
	Mon,  9 Oct 2023 20:51:06 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C000336E1;
	Mon,  9 Oct 2023 20:51:05 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 07/14] tls: move tls_prot_info initialization out of tls_set_sw_offload
Date: Mon,  9 Oct 2023 22:50:47 +0200
Message-ID: <0c5dfcabbbab610decbd75b581848dd72c0842b9.1696596130.git.sd@queasysnail.net>
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
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simplify tls_set_sw_offload, and allow reuse for the tls_device code.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index b5428f543d17..b8e89bbb4a49 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2620,6 +2620,37 @@ static struct tls_sw_context_rx *init_ctx_rx(struct =
tls_context *ctx)
 =09return sw_ctx_rx;
 }
=20
+static int init_prot_info(struct tls_prot_info *prot,
+=09=09=09  const struct tls_crypto_info *crypto_info,
+=09=09=09  const struct tls_cipher_desc *cipher_desc)
+{
+=09u16 nonce_size =3D cipher_desc->nonce;
+
+=09if (crypto_info->version =3D=3D TLS_1_3_VERSION) {
+=09=09nonce_size =3D 0;
+=09=09prot->aad_size =3D TLS_HEADER_SIZE;
+=09=09prot->tail_size =3D 1;
+=09} else {
+=09=09prot->aad_size =3D TLS_AAD_SPACE_SIZE;
+=09=09prot->tail_size =3D 0;
+=09}
+
+=09/* Sanity-check the sizes for stack allocations. */
+=09if (nonce_size > TLS_MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE)
+=09=09return -EINVAL;
+
+=09prot->version =3D crypto_info->version;
+=09prot->cipher_type =3D crypto_info->cipher_type;
+=09prot->prepend_size =3D TLS_HEADER_SIZE + nonce_size;
+=09prot->tag_size =3D cipher_desc->tag;
+=09prot->overhead_size =3D prot->prepend_size + prot->tag_size + prot->tai=
l_size;
+=09prot->iv_size =3D cipher_desc->iv;
+=09prot->salt_size =3D cipher_desc->salt;
+=09prot->rec_seq_size =3D cipher_desc->rec_seq;
+
+=09return 0;
+}
+
 int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 {
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
@@ -2632,7 +2663,6 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09struct crypto_tfm *tfm;
 =09char *iv, *rec_seq, *key, *salt;
 =09const struct tls_cipher_desc *cipher_desc;
-=09u16 nonce_size;
 =09int rc =3D 0;
=20
 =09if (!ctx) {
@@ -2666,39 +2696,15 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09goto free_priv;
 =09}
=20
-=09nonce_size =3D cipher_desc->nonce;
+=09rc =3D init_prot_info(prot, crypto_info, cipher_desc);
+=09if (rc)
+=09=09goto free_priv;
=20
 =09iv =3D crypto_info_iv(crypto_info, cipher_desc);
 =09key =3D crypto_info_key(crypto_info, cipher_desc);
 =09salt =3D crypto_info_salt(crypto_info, cipher_desc);
 =09rec_seq =3D crypto_info_rec_seq(crypto_info, cipher_desc);
=20
-=09if (crypto_info->version =3D=3D TLS_1_3_VERSION) {
-=09=09nonce_size =3D 0;
-=09=09prot->aad_size =3D TLS_HEADER_SIZE;
-=09=09prot->tail_size =3D 1;
-=09} else {
-=09=09prot->aad_size =3D TLS_AAD_SPACE_SIZE;
-=09=09prot->tail_size =3D 0;
-=09}
-
-=09/* Sanity-check the sizes for stack allocations. */
-=09if (nonce_size > TLS_MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE) =
{
-=09=09rc =3D -EINVAL;
-=09=09goto free_priv;
-=09}
-
-=09prot->version =3D crypto_info->version;
-=09prot->cipher_type =3D crypto_info->cipher_type;
-=09prot->prepend_size =3D TLS_HEADER_SIZE + nonce_size;
-=09prot->tag_size =3D cipher_desc->tag;
-=09prot->overhead_size =3D prot->prepend_size +
-=09=09=09      prot->tag_size + prot->tail_size;
-=09prot->iv_size =3D cipher_desc->iv;
-=09prot->salt_size =3D cipher_desc->salt;
-
-=09/* Note: 128 & 256 bit salt are the same size */
-=09prot->rec_seq_size =3D cipher_desc->rec_seq;
 =09memcpy(cctx->iv, salt, cipher_desc->salt);
 =09memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
 =09memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
--=20
2.42.0


