Return-Path: <netdev+bounces-30777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AA78907B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD08281970
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216A1988C;
	Fri, 25 Aug 2023 21:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B37193AC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F912691
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:20 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-lsokpBc7MF2BVT2OqibQcQ-1; Fri, 25 Aug 2023 17:36:16 -0400
X-MC-Unique: lsokpBc7MF2BVT2OqibQcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E86AF85C6E2;
	Fri, 25 Aug 2023 21:36:15 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25AB61678B;
	Fri, 25 Aug 2023 21:36:15 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 06/17] tls: reduce size of tls_cipher_size_desc
Date: Fri, 25 Aug 2023 23:35:11 +0200
Message-Id: <5e054e370e240247a5d37881a1cd93a67c15f4ca.1692977948.git.sd@queasysnail.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tls_cipher_size_desc indexes ciphers by their type, but we're not
using indices 0..50 of the array. Each struct tls_cipher_size_desc is
20B, so that's a lot of unused memory. We can reindex the array
starting at the lowest used cipher_type.

Introduce the get_cipher_size_desc helper to find the right item and
avoid out-of-bounds accesses, and make tls_cipher_size_desc's size
explicit so that gcc reminds us to update TLS_CIPHER_MIN/MAX when we
add a new cipher.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h                 | 13 ++++++++++++-
 net/tls/tls_device.c          |  4 ++--
 net/tls/tls_device_fallback.c |  8 ++++----
 net/tls/tls_main.c            |  4 ++--
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 7aae92972e00..ea799ef77bf8 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -59,7 +59,18 @@ struct tls_cipher_size_desc {
 =09unsigned int rec_seq;
 };
=20
-extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
+#define TLS_CIPHER_MIN TLS_CIPHER_AES_GCM_128
+#define TLS_CIPHER_MAX TLS_CIPHER_ARIA_GCM_256
+extern const struct tls_cipher_size_desc tls_cipher_size_desc[TLS_CIPHER_M=
AX + 1 - TLS_CIPHER_MIN];
+
+static inline const struct tls_cipher_size_desc *get_cipher_size_desc(u16 =
cipher_type)
+{
+=09if (cipher_type < TLS_CIPHER_MIN || cipher_type > TLS_CIPHER_MAX)
+=09=09return NULL;
+
+=09return &tls_cipher_size_desc[cipher_type - TLS_CIPHER_MIN];
+}
+
=20
 /* TLS records are maintained in 'struct tls_rec'. It stores the memory pa=
ges
  * allocated or mapped for each TLS record. After encryption, the records =
are
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 2392d06845aa..9bc42041c2ce 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -898,7 +898,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_contex=
t *tls_ctx)
 =09default:
 =09=09return -EINVAL;
 =09}
-=09cipher_sz =3D &tls_cipher_size_desc[tls_ctx->crypto_recv.info.cipher_ty=
pe];
+=09cipher_sz =3D get_cipher_size_desc(tls_ctx->crypto_recv.info.cipher_typ=
e);
=20
 =09rxm =3D strp_msg(tls_strp_msg(sw_ctx));
 =09orig_buf =3D kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_sz->iv,
@@ -1094,7 +1094,7 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 =09=09rc =3D -EINVAL;
 =09=09goto release_netdev;
 =09}
-=09cipher_sz =3D &tls_cipher_size_desc[crypto_info->cipher_type];
+=09cipher_sz =3D get_cipher_size_desc(crypto_info->cipher_type);
=20
 =09/* Sanity-check the rec_seq_size for stack allocations */
 =09if (cipher_sz->rec_seq > TLS_MAX_REC_SEQ_SIZE) {
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index b28c5e296dfd..dd21fa4961b6 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -69,7 +69,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 =09default:
 =09=09return -EINVAL;
 =09}
-=09cipher_sz =3D &tls_cipher_size_desc[prot->cipher_type];
+=09cipher_sz =3D get_cipher_size_desc(prot->cipher_type);
=20
 =09buf_size =3D TLS_HEADER_SIZE + cipher_sz->iv;
 =09len =3D min_t(int, *in_len, buf_size);
@@ -310,7 +310,7 @@ static void fill_sg_out(struct scatterlist sg_out[3], v=
oid *buf,
 =09=09=09void *dummy_buf)
 {
 =09const struct tls_cipher_size_desc *cipher_sz =3D
-=09=09&tls_cipher_size_desc[tls_ctx->crypto_send.info.cipher_type];
+=09=09get_cipher_size_desc(tls_ctx->crypto_send.info.cipher_type);
=20
 =09sg_set_buf(&sg_out[0], dummy_buf, sync_size);
 =09sg_set_buf(&sg_out[1], nskb->data + tcp_payload_offset, payload_len);
@@ -348,7 +348,7 @@ static struct sk_buff *tls_enc_skb(struct tls_context *=
tls_ctx,
 =09default:
 =09=09goto free_req;
 =09}
-=09cipher_sz =3D &tls_cipher_size_desc[tls_ctx->crypto_send.info.cipher_ty=
pe];
+=09cipher_sz =3D get_cipher_size_desc(tls_ctx->crypto_send.info.cipher_typ=
e);
 =09buf_len =3D cipher_sz->salt + cipher_sz->iv + TLS_AAD_SPACE_SIZE +
 =09=09  sync_size + cipher_sz->tag;
 =09buf =3D kmalloc(buf_len, GFP_ATOMIC);
@@ -495,7 +495,7 @@ int tls_sw_fallback_init(struct sock *sk,
 =09=09rc =3D -EINVAL;
 =09=09goto free_aead;
 =09}
-=09cipher_sz =3D &tls_cipher_size_desc[crypto_info->cipher_type];
+=09cipher_sz =3D get_cipher_size_desc(crypto_info->cipher_type);
=20
 =09rc =3D crypto_aead_setkey(offload_ctx->aead_send, key, cipher_sz->key);
 =09if (rc)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9843c2af994f..1bf04636948d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -58,7 +58,7 @@ enum {
 =09TLS_NUM_PROTS,
 };
=20
-#define CIPHER_SIZE_DESC(cipher) [cipher] =3D { \
+#define CIPHER_SIZE_DESC(cipher) [cipher - TLS_CIPHER_MIN] =3D {=09\
 =09.iv =3D cipher ## _IV_SIZE, \
 =09.key =3D cipher ## _KEY_SIZE, \
 =09.salt =3D cipher ## _SALT_SIZE, \
@@ -66,7 +66,7 @@ enum {
 =09.rec_seq =3D cipher ## _REC_SEQ_SIZE, \
 }
=20
-const struct tls_cipher_size_desc tls_cipher_size_desc[] =3D {
+const struct tls_cipher_size_desc tls_cipher_size_desc[TLS_CIPHER_MAX + 1 =
- TLS_CIPHER_MIN] =3D {
 =09CIPHER_SIZE_DESC(TLS_CIPHER_AES_GCM_128),
 =09CIPHER_SIZE_DESC(TLS_CIPHER_AES_GCM_256),
 =09CIPHER_SIZE_DESC(TLS_CIPHER_AES_CCM_128),
--=20
2.40.1


