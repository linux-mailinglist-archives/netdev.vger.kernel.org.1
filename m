Return-Path: <netdev+bounces-30786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A6789095
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DBA281593
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8DB1C2A3;
	Fri, 25 Aug 2023 21:38:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393C19883
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:38:00 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17CB270D
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:37:36 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-DRxeXPm1PZGw2pnGwnUJtA-1; Fri, 25 Aug 2023 17:37:10 -0400
X-MC-Unique: DRxeXPm1PZGw2pnGwnUJtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C268C800193;
	Fri, 25 Aug 2023 21:37:09 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A13255CC06;
	Fri, 25 Aug 2023 21:37:08 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 15/17] tls: use tls_cipher_desc to get per-cipher sizes in tls_set_sw_offload
Date: Fri, 25 Aug 2023 23:35:20 +0200
Message-Id: <deed9c4430a62c31751a72b8c03ad66ffe710717.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We can get rid of some local variables, but we have to keep nonce_size
because tls1.3 uses nonce_size =3D 0 for all ciphers.

We can also drop the runtime sanity checks on iv/rec_seq/tag size,
since we have compile time checks on those values.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 79 ++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 63 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5c122d7bb784..85708656dcd4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2590,10 +2590,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09struct tls_sw_context_rx *sw_ctx_rx =3D NULL;
 =09struct cipher_context *cctx;
 =09struct crypto_aead **aead;
-=09u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
 =09struct crypto_tfm *tfm;
 =09char *iv, *rec_seq, *key, *salt, *cipher_name;
-=09size_t keysize;
+=09const struct tls_cipher_desc *cipher_desc;
+=09u16 nonce_size;
 =09int rc =3D 0;
=20
 =09if (!ctx) {
@@ -2652,16 +2652,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_aes_gcm_128 *gcm_128_info;
=20
 =09=09gcm_128_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_AES_GCM_128_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_AES_GCM_128_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_AES_GCM_128_IV_SIZE;
 =09=09iv =3D gcm_128_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE;
 =09=09rec_seq =3D gcm_128_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_AES_GCM_128_KEY_SIZE;
 =09=09key =3D gcm_128_info->key;
 =09=09salt =3D gcm_128_info->salt;
-=09=09salt_size =3D TLS_CIPHER_AES_GCM_128_SALT_SIZE;
 =09=09cipher_name =3D "gcm(aes)";
 =09=09break;
 =09}
@@ -2669,16 +2663,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_aes_gcm_256 *gcm_256_info;
=20
 =09=09gcm_256_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_AES_GCM_256_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_AES_GCM_256_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_AES_GCM_256_IV_SIZE;
 =09=09iv =3D gcm_256_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_AES_GCM_256_REC_SEQ_SIZE;
 =09=09rec_seq =3D gcm_256_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_AES_GCM_256_KEY_SIZE;
 =09=09key =3D gcm_256_info->key;
 =09=09salt =3D gcm_256_info->salt;
-=09=09salt_size =3D TLS_CIPHER_AES_GCM_256_SALT_SIZE;
 =09=09cipher_name =3D "gcm(aes)";
 =09=09break;
 =09}
@@ -2686,16 +2674,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_aes_ccm_128 *ccm_128_info;
=20
 =09=09ccm_128_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_AES_CCM_128_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_AES_CCM_128_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_AES_CCM_128_IV_SIZE;
 =09=09iv =3D ccm_128_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_AES_CCM_128_REC_SEQ_SIZE;
 =09=09rec_seq =3D ccm_128_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_AES_CCM_128_KEY_SIZE;
 =09=09key =3D ccm_128_info->key;
 =09=09salt =3D ccm_128_info->salt;
-=09=09salt_size =3D TLS_CIPHER_AES_CCM_128_SALT_SIZE;
 =09=09cipher_name =3D "ccm(aes)";
 =09=09break;
 =09}
@@ -2703,16 +2685,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_chacha20_poly1305 *chacha20_poly1305_info;
=20
 =09=09chacha20_poly1305_info =3D (void *)crypto_info;
-=09=09nonce_size =3D 0;
-=09=09tag_size =3D TLS_CIPHER_CHACHA20_POLY1305_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_CHACHA20_POLY1305_IV_SIZE;
 =09=09iv =3D chacha20_poly1305_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_CHACHA20_POLY1305_REC_SEQ_SIZE;
 =09=09rec_seq =3D chacha20_poly1305_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_CHACHA20_POLY1305_KEY_SIZE;
 =09=09key =3D chacha20_poly1305_info->key;
 =09=09salt =3D chacha20_poly1305_info->salt;
-=09=09salt_size =3D TLS_CIPHER_CHACHA20_POLY1305_SALT_SIZE;
 =09=09cipher_name =3D "rfc7539(chacha20,poly1305)";
 =09=09break;
 =09}
@@ -2720,16 +2696,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_sm4_gcm *sm4_gcm_info;
=20
 =09=09sm4_gcm_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_SM4_GCM_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_SM4_GCM_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_SM4_GCM_IV_SIZE;
 =09=09iv =3D sm4_gcm_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_SM4_GCM_REC_SEQ_SIZE;
 =09=09rec_seq =3D sm4_gcm_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_SM4_GCM_KEY_SIZE;
 =09=09key =3D sm4_gcm_info->key;
 =09=09salt =3D sm4_gcm_info->salt;
-=09=09salt_size =3D TLS_CIPHER_SM4_GCM_SALT_SIZE;
 =09=09cipher_name =3D "gcm(sm4)";
 =09=09break;
 =09}
@@ -2737,16 +2707,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_sm4_ccm *sm4_ccm_info;
=20
 =09=09sm4_ccm_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_SM4_CCM_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_SM4_CCM_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_SM4_CCM_IV_SIZE;
 =09=09iv =3D sm4_ccm_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_SM4_CCM_REC_SEQ_SIZE;
 =09=09rec_seq =3D sm4_ccm_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_SM4_CCM_KEY_SIZE;
 =09=09key =3D sm4_ccm_info->key;
 =09=09salt =3D sm4_ccm_info->salt;
-=09=09salt_size =3D TLS_CIPHER_SM4_CCM_SALT_SIZE;
 =09=09cipher_name =3D "ccm(sm4)";
 =09=09break;
 =09}
@@ -2754,16 +2718,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_aria_gcm_128 *aria_gcm_128_info;
=20
 =09=09aria_gcm_128_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_ARIA_GCM_128_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_ARIA_GCM_128_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_ARIA_GCM_128_IV_SIZE;
 =09=09iv =3D aria_gcm_128_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_ARIA_GCM_128_REC_SEQ_SIZE;
 =09=09rec_seq =3D aria_gcm_128_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_ARIA_GCM_128_KEY_SIZE;
 =09=09key =3D aria_gcm_128_info->key;
 =09=09salt =3D aria_gcm_128_info->salt;
-=09=09salt_size =3D TLS_CIPHER_ARIA_GCM_128_SALT_SIZE;
 =09=09cipher_name =3D "gcm(aria)";
 =09=09break;
 =09}
@@ -2771,16 +2729,10 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09struct tls12_crypto_info_aria_gcm_256 *gcm_256_info;
=20
 =09=09gcm_256_info =3D (void *)crypto_info;
-=09=09nonce_size =3D TLS_CIPHER_ARIA_GCM_256_IV_SIZE;
-=09=09tag_size =3D TLS_CIPHER_ARIA_GCM_256_TAG_SIZE;
-=09=09iv_size =3D TLS_CIPHER_ARIA_GCM_256_IV_SIZE;
 =09=09iv =3D gcm_256_info->iv;
-=09=09rec_seq_size =3D TLS_CIPHER_ARIA_GCM_256_REC_SEQ_SIZE;
 =09=09rec_seq =3D gcm_256_info->rec_seq;
-=09=09keysize =3D TLS_CIPHER_ARIA_GCM_256_KEY_SIZE;
 =09=09key =3D gcm_256_info->key;
 =09=09salt =3D gcm_256_info->salt;
-=09=09salt_size =3D TLS_CIPHER_ARIA_GCM_256_SALT_SIZE;
 =09=09cipher_name =3D "gcm(aria)";
 =09=09break;
 =09}
@@ -2789,6 +2741,9 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09=09goto free_priv;
 =09}
=20
+=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
+=09nonce_size =3D cipher_desc->nonce;
+
 =09if (crypto_info->version =3D=3D TLS_1_3_VERSION) {
 =09=09nonce_size =3D 0;
 =09=09prot->aad_size =3D TLS_HEADER_SIZE;
@@ -2799,9 +2754,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09}
=20
 =09/* Sanity-check the sizes for stack allocations. */
-=09if (iv_size > MAX_IV_SIZE || nonce_size > MAX_IV_SIZE ||
-=09    rec_seq_size > TLS_MAX_REC_SEQ_SIZE || tag_size !=3D TLS_TAG_SIZE |=
|
-=09    prot->aad_size > TLS_MAX_AAD_SIZE) {
+=09if (nonce_size > MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE) {
 =09=09rc =3D -EINVAL;
 =09=09goto free_priv;
 =09}
@@ -2809,21 +2762,22 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09prot->version =3D crypto_info->version;
 =09prot->cipher_type =3D crypto_info->cipher_type;
 =09prot->prepend_size =3D TLS_HEADER_SIZE + nonce_size;
-=09prot->tag_size =3D tag_size;
+=09prot->tag_size =3D cipher_desc->tag;
 =09prot->overhead_size =3D prot->prepend_size +
 =09=09=09      prot->tag_size + prot->tail_size;
-=09prot->iv_size =3D iv_size;
-=09prot->salt_size =3D salt_size;
-=09cctx->iv =3D kmalloc(iv_size + salt_size, GFP_KERNEL);
+=09prot->iv_size =3D cipher_desc->iv;
+=09prot->salt_size =3D cipher_desc->salt;
+=09cctx->iv =3D kmalloc(cipher_desc->iv + cipher_desc->salt, GFP_KERNEL);
 =09if (!cctx->iv) {
 =09=09rc =3D -ENOMEM;
 =09=09goto free_priv;
 =09}
 =09/* Note: 128 & 256 bit salt are the same size */
-=09prot->rec_seq_size =3D rec_seq_size;
-=09memcpy(cctx->iv, salt, salt_size);
-=09memcpy(cctx->iv + salt_size, iv, iv_size);
-=09cctx->rec_seq =3D kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
+=09prot->rec_seq_size =3D cipher_desc->rec_seq;
+=09memcpy(cctx->iv, salt, cipher_desc->salt);
+=09memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
+
+=09cctx->rec_seq =3D kmemdup(rec_seq, cipher_desc->rec_seq, GFP_KERNEL);
 =09if (!cctx->rec_seq) {
 =09=09rc =3D -ENOMEM;
 =09=09goto free_iv;
@@ -2840,8 +2794,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
=20
 =09ctx->push_pending_record =3D tls_sw_push_pending_record;
=20
-=09rc =3D crypto_aead_setkey(*aead, key, keysize);
-
+=09rc =3D crypto_aead_setkey(*aead, key, cipher_desc->key);
 =09if (rc)
 =09=09goto free_aead;
=20
--=20
2.40.1


