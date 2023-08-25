Return-Path: <netdev+bounces-30779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE978907E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2039C28194C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F441AA98;
	Fri, 25 Aug 2023 21:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6988193BF
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:38 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C97726AD
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:37 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-mfeQdHrBOsmVOZtngLbaKg-1; Fri, 25 Aug 2023 17:36:19 -0400
X-MC-Unique: mfeQdHrBOsmVOZtngLbaKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 439AB101A59A;
	Fri, 25 Aug 2023 21:36:19 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 659671678B;
	Fri, 25 Aug 2023 21:36:18 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 07/17] tls: rename tls_cipher_size_desc to tls_cipher_desc
Date: Fri, 25 Aug 2023 23:35:12 +0200
Message-Id: <76ca6c7686bd6d1534dfa188fb0f1f6fabebc791.1692977948.git.sd@queasysnail.net>
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

We're going to add other fields to it to fully describe a cipher, so
the "_size" name won't match the contents.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h                 |  8 +++----
 net/tls/tls_device.c          | 34 ++++++++++++++--------------
 net/tls/tls_device_fallback.c | 42 +++++++++++++++++------------------
 net/tls/tls_main.c            | 20 ++++++++---------
 4 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index ea799ef77bf8..d4b56ca9d267 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -51,7 +51,7 @@
 #define TLS_DEC_STATS(net, field)=09=09=09=09\
 =09SNMP_DEC_STATS((net)->mib.tls_statistics, field)
=20
-struct tls_cipher_size_desc {
+struct tls_cipher_desc {
 =09unsigned int iv;
 =09unsigned int key;
 =09unsigned int salt;
@@ -61,14 +61,14 @@ struct tls_cipher_size_desc {
=20
 #define TLS_CIPHER_MIN TLS_CIPHER_AES_GCM_128
 #define TLS_CIPHER_MAX TLS_CIPHER_ARIA_GCM_256
-extern const struct tls_cipher_size_desc tls_cipher_size_desc[TLS_CIPHER_M=
AX + 1 - TLS_CIPHER_MIN];
+extern const struct tls_cipher_desc tls_cipher_desc[TLS_CIPHER_MAX + 1 - T=
LS_CIPHER_MIN];
=20
-static inline const struct tls_cipher_size_desc *get_cipher_size_desc(u16 =
cipher_type)
+static inline const struct tls_cipher_desc *get_cipher_desc(u16 cipher_typ=
e)
 {
 =09if (cipher_type < TLS_CIPHER_MIN || cipher_type > TLS_CIPHER_MAX)
 =09=09return NULL;
=20
-=09return &tls_cipher_size_desc[cipher_type - TLS_CIPHER_MIN];
+=09return &tls_cipher_desc[cipher_type - TLS_CIPHER_MIN];
 }
=20
=20
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 9bc42041c2ce..98885d872d4c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -884,7 +884,7 @@ static int
 tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 {
 =09struct tls_sw_context_rx *sw_ctx =3D tls_sw_ctx_rx(tls_ctx);
-=09const struct tls_cipher_size_desc *cipher_sz;
+=09const struct tls_cipher_desc *cipher_desc;
 =09int err, offset, copy, data_len, pos;
 =09struct sk_buff *skb, *skb_iter;
 =09struct scatterlist sg[1];
@@ -898,10 +898,10 @@ tls_device_reencrypt(struct sock *sk, struct tls_cont=
ext *tls_ctx)
 =09default:
 =09=09return -EINVAL;
 =09}
-=09cipher_sz =3D get_cipher_size_desc(tls_ctx->crypto_recv.info.cipher_typ=
e);
+=09cipher_desc =3D get_cipher_desc(tls_ctx->crypto_recv.info.cipher_type);
=20
 =09rxm =3D strp_msg(tls_strp_msg(sw_ctx));
-=09orig_buf =3D kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_sz->iv,
+=09orig_buf =3D kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
 =09=09=09   sk->sk_allocation);
 =09if (!orig_buf)
 =09=09return -ENOMEM;
@@ -917,8 +917,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_contex=
t *tls_ctx)
=20
 =09sg_init_table(sg, 1);
 =09sg_set_buf(&sg[0], buf,
-=09=09   rxm->full_len + TLS_HEADER_SIZE + cipher_sz->iv);
-=09err =3D skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_sz->iv=
);
+=09=09   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
+=09err =3D skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->=
iv);
 =09if (err)
 =09=09goto free_buf;
=20
@@ -929,7 +929,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_contex=
t *tls_ctx)
 =09else
 =09=09err =3D 0;
=20
-=09data_len =3D rxm->full_len - cipher_sz->tag;
+=09data_len =3D rxm->full_len - cipher_desc->tag;
=20
 =09if (skb_pagelen(skb) > offset) {
 =09=09copy =3D min_t(int, skb_pagelen(skb) - offset, data_len);
@@ -1046,7 +1046,7 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 {
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
 =09struct tls_prot_info *prot =3D &tls_ctx->prot_info;
-=09const struct tls_cipher_size_desc *cipher_sz;
+=09const struct tls_cipher_desc *cipher_desc;
 =09struct tls_record_info *start_marker_record;
 =09struct tls_offload_context_tx *offload_ctx;
 =09struct tls_crypto_info *crypto_info;
@@ -1094,31 +1094,31 @@ int tls_set_device_offload(struct sock *sk, struct =
tls_context *ctx)
 =09=09rc =3D -EINVAL;
 =09=09goto release_netdev;
 =09}
-=09cipher_sz =3D get_cipher_size_desc(crypto_info->cipher_type);
+=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
=20
 =09/* Sanity-check the rec_seq_size for stack allocations */
-=09if (cipher_sz->rec_seq > TLS_MAX_REC_SEQ_SIZE) {
+=09if (cipher_desc->rec_seq > TLS_MAX_REC_SEQ_SIZE) {
 =09=09rc =3D -EINVAL;
 =09=09goto release_netdev;
 =09}
=20
 =09prot->version =3D crypto_info->version;
 =09prot->cipher_type =3D crypto_info->cipher_type;
-=09prot->prepend_size =3D TLS_HEADER_SIZE + cipher_sz->iv;
-=09prot->tag_size =3D cipher_sz->tag;
+=09prot->prepend_size =3D TLS_HEADER_SIZE + cipher_desc->iv;
+=09prot->tag_size =3D cipher_desc->tag;
 =09prot->overhead_size =3D prot->prepend_size + prot->tag_size;
-=09prot->iv_size =3D cipher_sz->iv;
-=09prot->salt_size =3D cipher_sz->salt;
-=09ctx->tx.iv =3D kmalloc(cipher_sz->iv + cipher_sz->salt, GFP_KERNEL);
+=09prot->iv_size =3D cipher_desc->iv;
+=09prot->salt_size =3D cipher_desc->salt;
+=09ctx->tx.iv =3D kmalloc(cipher_desc->iv + cipher_desc->salt, GFP_KERNEL)=
;
 =09if (!ctx->tx.iv) {
 =09=09rc =3D -ENOMEM;
 =09=09goto release_netdev;
 =09}
=20
-=09memcpy(ctx->tx.iv + cipher_sz->salt, iv, cipher_sz->iv);
+=09memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
=20
-=09prot->rec_seq_size =3D cipher_sz->rec_seq;
-=09ctx->tx.rec_seq =3D kmemdup(rec_seq, cipher_sz->rec_seq, GFP_KERNEL);
+=09prot->rec_seq_size =3D cipher_desc->rec_seq;
+=09ctx->tx.rec_seq =3D kmemdup(rec_seq, cipher_desc->rec_seq, GFP_KERNEL);
 =09if (!ctx->tx.rec_seq) {
 =09=09rc =3D -ENOMEM;
 =09=09goto free_iv;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index dd21fa4961b6..cb224fb2a394 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -55,7 +55,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 =09=09=09  struct tls_prot_info *prot)
 {
 =09unsigned char buf[TLS_HEADER_SIZE + MAX_IV_SIZE];
-=09const struct tls_cipher_size_desc *cipher_sz;
+=09const struct tls_cipher_desc *cipher_desc;
 =09struct scatterlist sg_in[3];
 =09struct scatterlist sg_out[3];
 =09unsigned int buf_size;
@@ -69,9 +69,9 @@ static int tls_enc_record(struct aead_request *aead_req,
 =09default:
 =09=09return -EINVAL;
 =09}
-=09cipher_sz =3D get_cipher_size_desc(prot->cipher_type);
+=09cipher_desc =3D get_cipher_desc(prot->cipher_type);
=20
-=09buf_size =3D TLS_HEADER_SIZE + cipher_sz->iv;
+=09buf_size =3D TLS_HEADER_SIZE + cipher_desc->iv;
 =09len =3D min_t(int, *in_len, buf_size);
=20
 =09scatterwalk_copychunks(buf, in, len, 0);
@@ -85,11 +85,11 @@ static int tls_enc_record(struct aead_request *aead_req=
,
 =09scatterwalk_pagedone(out, 1, 1);
=20
 =09len =3D buf[4] | (buf[3] << 8);
-=09len -=3D cipher_sz->iv;
+=09len -=3D cipher_desc->iv;
=20
-=09tls_make_aad(aad, len - cipher_sz->tag, (char *)&rcd_sn, buf[0], prot);
+=09tls_make_aad(aad, len - cipher_desc->tag, (char *)&rcd_sn, buf[0], prot=
);
=20
-=09memcpy(iv + cipher_sz->salt, buf + TLS_HEADER_SIZE, cipher_sz->iv);
+=09memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE, cipher_desc->iv);
=20
 =09sg_init_table(sg_in, ARRAY_SIZE(sg_in));
 =09sg_init_table(sg_out, ARRAY_SIZE(sg_out));
@@ -100,7 +100,7 @@ static int tls_enc_record(struct aead_request *aead_req=
,
=20
 =09*in_len -=3D len;
 =09if (*in_len < 0) {
-=09=09*in_len +=3D cipher_sz->tag;
+=09=09*in_len +=3D cipher_desc->tag;
 =09=09/* the input buffer doesn't contain the entire record.
 =09=09 * trim len accordingly. The resulting authentication tag
 =09=09 * will contain garbage, but we don't care, so we won't
@@ -121,7 +121,7 @@ static int tls_enc_record(struct aead_request *aead_req=
,
 =09=09scatterwalk_pagedone(out, 1, 1);
 =09}
=20
-=09len -=3D cipher_sz->tag;
+=09len -=3D cipher_desc->tag;
 =09aead_request_set_crypt(aead_req, sg_in, sg_out, len, iv);
=20
 =09rc =3D crypto_aead_encrypt(aead_req);
@@ -309,14 +309,14 @@ static void fill_sg_out(struct scatterlist sg_out[3],=
 void *buf,
 =09=09=09int sync_size,
 =09=09=09void *dummy_buf)
 {
-=09const struct tls_cipher_size_desc *cipher_sz =3D
-=09=09get_cipher_size_desc(tls_ctx->crypto_send.info.cipher_type);
+=09const struct tls_cipher_desc *cipher_desc =3D
+=09=09get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
=20
 =09sg_set_buf(&sg_out[0], dummy_buf, sync_size);
 =09sg_set_buf(&sg_out[1], nskb->data + tcp_payload_offset, payload_len);
 =09/* Add room for authentication tag produced by crypto */
 =09dummy_buf +=3D sync_size;
-=09sg_set_buf(&sg_out[2], dummy_buf, cipher_sz->tag);
+=09sg_set_buf(&sg_out[2], dummy_buf, cipher_desc->tag);
 }
=20
 static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
@@ -328,7 +328,7 @@ static struct sk_buff *tls_enc_skb(struct tls_context *=
tls_ctx,
 =09struct tls_offload_context_tx *ctx =3D tls_offload_ctx_tx(tls_ctx);
 =09int tcp_payload_offset =3D skb_tcp_all_headers(skb);
 =09int payload_len =3D skb->len - tcp_payload_offset;
-=09const struct tls_cipher_size_desc *cipher_sz;
+=09const struct tls_cipher_desc *cipher_desc;
 =09void *buf, *iv, *aad, *dummy_buf, *salt;
 =09struct aead_request *aead_req;
 =09struct sk_buff *nskb =3D NULL;
@@ -348,16 +348,16 @@ static struct sk_buff *tls_enc_skb(struct tls_context=
 *tls_ctx,
 =09default:
 =09=09goto free_req;
 =09}
-=09cipher_sz =3D get_cipher_size_desc(tls_ctx->crypto_send.info.cipher_typ=
e);
-=09buf_len =3D cipher_sz->salt + cipher_sz->iv + TLS_AAD_SPACE_SIZE +
-=09=09  sync_size + cipher_sz->tag;
+=09cipher_desc =3D get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
+=09buf_len =3D cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
+=09=09  sync_size + cipher_desc->tag;
 =09buf =3D kmalloc(buf_len, GFP_ATOMIC);
 =09if (!buf)
 =09=09goto free_req;
=20
 =09iv =3D buf;
-=09memcpy(iv, salt, cipher_sz->salt);
-=09aad =3D buf + cipher_sz->salt + cipher_sz->iv;
+=09memcpy(iv, salt, cipher_desc->salt);
+=09aad =3D buf + cipher_desc->salt + cipher_desc->iv;
 =09dummy_buf =3D aad + TLS_AAD_SPACE_SIZE;
=20
 =09nskb =3D alloc_skb(skb_headroom(skb) + skb->len, GFP_ATOMIC);
@@ -471,7 +471,7 @@ int tls_sw_fallback_init(struct sock *sk,
 =09=09=09 struct tls_offload_context_tx *offload_ctx,
 =09=09=09 struct tls_crypto_info *crypto_info)
 {
-=09const struct tls_cipher_size_desc *cipher_sz;
+=09const struct tls_cipher_desc *cipher_desc;
 =09const u8 *key;
 =09int rc;
=20
@@ -495,13 +495,13 @@ int tls_sw_fallback_init(struct sock *sk,
 =09=09rc =3D -EINVAL;
 =09=09goto free_aead;
 =09}
-=09cipher_sz =3D get_cipher_size_desc(crypto_info->cipher_type);
+=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
=20
-=09rc =3D crypto_aead_setkey(offload_ctx->aead_send, key, cipher_sz->key);
+=09rc =3D crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key=
);
 =09if (rc)
 =09=09goto free_aead;
=20
-=09rc =3D crypto_aead_setauthsize(offload_ctx->aead_send, cipher_sz->tag);
+=09rc =3D crypto_aead_setauthsize(offload_ctx->aead_send, cipher_desc->tag=
);
 =09if (rc)
 =09=09goto free_aead;
=20
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1bf04636948d..217c2aa004dc 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -58,7 +58,7 @@ enum {
 =09TLS_NUM_PROTS,
 };
=20
-#define CIPHER_SIZE_DESC(cipher) [cipher - TLS_CIPHER_MIN] =3D {=09\
+#define CIPHER_DESC(cipher) [cipher - TLS_CIPHER_MIN] =3D {=09\
 =09.iv =3D cipher ## _IV_SIZE, \
 =09.key =3D cipher ## _KEY_SIZE, \
 =09.salt =3D cipher ## _SALT_SIZE, \
@@ -66,15 +66,15 @@ enum {
 =09.rec_seq =3D cipher ## _REC_SEQ_SIZE, \
 }
=20
-const struct tls_cipher_size_desc tls_cipher_size_desc[TLS_CIPHER_MAX + 1 =
- TLS_CIPHER_MIN] =3D {
-=09CIPHER_SIZE_DESC(TLS_CIPHER_AES_GCM_128),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_AES_GCM_256),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_AES_CCM_128),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_CHACHA20_POLY1305),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_SM4_GCM),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_SM4_CCM),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_ARIA_GCM_128),
-=09CIPHER_SIZE_DESC(TLS_CIPHER_ARIA_GCM_256),
+const struct tls_cipher_desc tls_cipher_desc[TLS_CIPHER_MAX + 1 - TLS_CIPH=
ER_MIN] =3D {
+=09CIPHER_DESC(TLS_CIPHER_AES_GCM_128),
+=09CIPHER_DESC(TLS_CIPHER_AES_GCM_256),
+=09CIPHER_DESC(TLS_CIPHER_AES_CCM_128),
+=09CIPHER_DESC(TLS_CIPHER_CHACHA20_POLY1305),
+=09CIPHER_DESC(TLS_CIPHER_SM4_GCM),
+=09CIPHER_DESC(TLS_CIPHER_SM4_CCM),
+=09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128),
+=09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256),
 };
=20
 static const struct proto *saved_tcpv6_prot;
--=20
2.40.1


