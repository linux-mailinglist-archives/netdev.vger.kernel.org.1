Return-Path: <netdev+bounces-25853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55385776016
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205C41C21233
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441AB18C0D;
	Wed,  9 Aug 2023 12:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7518AF6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:59:49 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47CF1FF9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:59:47 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-RR7Vi7HsPUCu7CzNB5blJg-1; Wed, 09 Aug 2023 08:59:27 -0400
X-MC-Unique: RR7Vi7HsPUCu7CzNB5blJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14DD885CBE7;
	Wed,  9 Aug 2023 12:59:27 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 362132166B25;
	Wed,  9 Aug 2023 12:59:25 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Date: Wed,  9 Aug 2023 14:58:52 +0200
Message-Id: <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
In-Reply-To: <cover.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This adds the possibility to change the key and IV when using
TLS1.3. Changing the cipher or TLS version is not supported.

Once we have updated the RX key, we can unblock the receive side. If
the rekey fails, the context is unmodified and userspace is free to
retry the update or close the socket.

This change only affects tls_sw, since 1.3 offload isn't supported.

v2:
 - reverse xmas tree
 - turn the alt_crypto_info into an else if
 - don't modify the context when rekey fails

v3:
 - only call tls_sw_strparser_arm when setting the initial RX key, not
   on rekeys
 - update tls_sk_poll to not say the socket is readable when we're
   waiting for a rekey, and wake up poll() when the new key is installed
 - use unsafe_memcpy to make FORTIFY_SOURCE happy

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |   3 +-
 net/tls/tls_device.c |   2 +-
 net/tls/tls_main.c   |  47 +++++++++++----
 net/tls/tls_sw.c     | 137 +++++++++++++++++++++++++++++++------------
 4 files changed, 138 insertions(+), 51 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 6916ff4fbde6..fd80cfc7604a 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -89,7 +89,8 @@ void update_sk_prot(struct sock *sk, struct tls_context *=
ctx);
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
=20
-int tls_set_sw_offload(struct sock *sk, int tx);
+int tls_set_sw_offload(struct sock *sk, int tx,
+=09=09       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index cc1918a279d4..af269875a772 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1275,7 +1275,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct=
 tls_context *ctx)
 =09context->resync_nh_reset =3D 1;
=20
 =09ctx->priv_ctx_rx =3D context;
-=09rc =3D tls_set_sw_offload(sk, 0);
+=09rc =3D tls_set_sw_offload(sk, 0, NULL);
 =09if (rc)
 =09=09goto release_ctx;
=20
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index ffc50454758e..a5dfb562d99b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -380,9 +380,10 @@ static __poll_t tls_sk_poll(struct file *file, struct =
socket *sock,
 =09ctx =3D tls_sw_ctx_rx(tls_ctx);
 =09psock =3D sk_psock_get(sk);
=20
-=09if (skb_queue_empty_lockless(&ctx->rx_list) &&
-=09    !tls_strp_msg_ready(ctx) &&
-=09    sk_psock_queue_empty(psock))
+=09if ((skb_queue_empty_lockless(&ctx->rx_list) &&
+=09     !tls_strp_msg_ready(ctx) &&
+=09     sk_psock_queue_empty(psock)) ||
+=09    READ_ONCE(ctx->key_update_pending))
 =09=09mask &=3D ~(EPOLLIN | EPOLLRDNORM);
=20
 =09if (psock)
@@ -696,9 +697,11 @@ static int tls_getsockopt(struct sock *sk, int level, =
int optname,
 static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 =09=09=09=09  unsigned int optlen, int tx)
 {
-=09struct tls_crypto_info *crypto_info;
-=09struct tls_crypto_info *alt_crypto_info;
+=09struct tls_crypto_info *crypto_info, *alt_crypto_info;
+=09struct tls_crypto_info *old_crypto_info =3D NULL;
 =09struct tls_context *ctx =3D tls_get_ctx(sk);
+=09union tls_crypto_context tmp =3D {};
+=09bool update =3D false;
 =09size_t optsize;
 =09int rc =3D 0;
 =09int conf;
@@ -714,9 +717,17 @@ static int do_tls_setsockopt_conf(struct sock *sk, soc=
kptr_t optval,
 =09=09alt_crypto_info =3D &ctx->crypto_send.info;
 =09}
=20
-=09/* Currently we don't support set crypto info more than one time */
-=09if (TLS_CRYPTO_INFO_READY(crypto_info))
-=09=09return -EBUSY;
+=09if (TLS_CRYPTO_INFO_READY(crypto_info)) {
+=09=09/* Currently we only support setting crypto info more
+=09=09 * than one time for TLS 1.3
+=09=09 */
+=09=09if (crypto_info->version !=3D TLS_1_3_VERSION)
+=09=09=09return -EBUSY;
+
+=09=09update =3D true;
+=09=09old_crypto_info =3D crypto_info;
+=09=09crypto_info =3D &tmp.info;
+=09}
=20
 =09rc =3D copy_from_sockptr(crypto_info, optval, sizeof(*crypto_info));
 =09if (rc) {
@@ -731,8 +742,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, soc=
kptr_t optval,
 =09=09goto err_crypto_info;
 =09}
=20
-=09/* Ensure that TLS version and ciphers are same in both directions */
-=09if (TLS_CRYPTO_INFO_READY(alt_crypto_info)) {
+=09if (update) {
+=09=09/* Ensure that TLS version and ciphers are not modified */
+=09=09if (crypto_info->version !=3D old_crypto_info->version ||
+=09=09    crypto_info->cipher_type !=3D old_crypto_info->cipher_type) {
+=09=09=09rc =3D -EINVAL;
+=09=09=09goto err_crypto_info;
+=09=09}
+=09} else if (TLS_CRYPTO_INFO_READY(alt_crypto_info)) {
+=09=09/* Ensure that TLS version and ciphers are same in both directions *=
/
 =09=09if (alt_crypto_info->version !=3D crypto_info->version ||
 =09=09    alt_crypto_info->cipher_type !=3D crypto_info->cipher_type) {
 =09=09=09rc =3D -EINVAL;
@@ -799,7 +817,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 =09=09} else {
-=09=09=09rc =3D tls_set_sw_offload(sk, 1);
+=09=09=09rc =3D tls_set_sw_offload(sk, 1,
+=09=09=09=09=09=09update ? crypto_info : NULL);
 =09=09=09if (rc)
 =09=09=09=09goto err_crypto_info;
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
@@ -813,14 +832,16 @@ static int do_tls_setsockopt_conf(struct sock *sk, so=
ckptr_t optval,
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
 =09=09} else {
-=09=09=09rc =3D tls_set_sw_offload(sk, 0);
+=09=09=09rc =3D tls_set_sw_offload(sk, 0,
+=09=09=09=09=09=09update ? crypto_info : NULL);
 =09=09=09if (rc)
 =09=09=09=09goto err_crypto_info;
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
 =09=09=09conf =3D TLS_SW;
 =09=09}
-=09=09tls_sw_strparser_arm(sk, ctx);
+=09=09if (!update)
+=09=09=09tls_sw_strparser_arm(sk, ctx);
 =09}
=20
 =09if (tx)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 497f56c5f169..bb5560fc8bcf 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2616,23 +2616,52 @@ void tls_update_rx_zc_capable(struct tls_context *t=
ls_ctx)
 =09=09tls_ctx->prot_info.version !=3D TLS_1_3_VERSION;
 }
=20
-int tls_set_sw_offload(struct sock *sk, int tx)
+static void tls_finish_key_update(struct sock *sk, struct tls_context *tls=
_ctx)
+{
+=09struct tls_sw_context_rx *ctx =3D tls_ctx->priv_ctx_rx;
+
+=09WRITE_ONCE(ctx->key_update_pending, false);
+=09/* wake-up pre-existing poll() */
+=09ctx->saved_data_ready(sk);
+}
+
+int tls_set_sw_offload(struct sock *sk, int tx,
+=09=09       struct tls_crypto_info *new_crypto_info)
 {
 =09u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
+=09struct tls_crypto_info *crypto_info, *src_crypto_info;
 =09char *iv, *rec_seq, *key, *salt, *cipher_name;
 =09struct tls_sw_context_tx *sw_ctx_tx =3D NULL;
 =09struct tls_sw_context_rx *sw_ctx_rx =3D NULL;
 =09struct tls_context *ctx =3D tls_get_ctx(sk);
-=09struct tls_crypto_info *crypto_info;
+=09size_t keysize, crypto_info_size;
 =09struct cipher_context *cctx;
 =09struct tls_prot_info *prot;
 =09struct crypto_aead **aead;
 =09struct crypto_tfm *tfm;
-=09size_t keysize;
 =09int rc =3D 0;
=20
 =09prot =3D &ctx->prot_info;
=20
+=09if (new_crypto_info) {
+=09=09/* non-NULL new_crypto_info means rekey */
+=09=09src_crypto_info =3D new_crypto_info;
+=09=09if (tx) {
+=09=09=09sw_ctx_tx =3D ctx->priv_ctx_tx;
+=09=09=09crypto_info =3D &ctx->crypto_send.info;
+=09=09=09cctx =3D &ctx->tx;
+=09=09=09aead =3D &sw_ctx_tx->aead_send;
+=09=09=09sw_ctx_tx =3D NULL;
+=09=09} else {
+=09=09=09sw_ctx_rx =3D ctx->priv_ctx_rx;
+=09=09=09crypto_info =3D &ctx->crypto_recv.info;
+=09=09=09cctx =3D &ctx->rx;
+=09=09=09aead =3D &sw_ctx_rx->aead_recv;
+=09=09=09sw_ctx_rx =3D NULL;
+=09=09}
+=09=09goto skip_init;
+=09}
+
 =09if (tx) {
 =09=09if (!ctx->priv_ctx_tx) {
 =09=09=09sw_ctx_tx =3D kzalloc(sizeof(*sw_ctx_tx), GFP_KERNEL);
@@ -2679,12 +2708,15 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09=09aead =3D &sw_ctx_rx->aead_recv;
 =09=09sw_ctx_rx->key_update_pending =3D false;
 =09}
+=09src_crypto_info =3D crypto_info;
=20
+skip_init:
 =09switch (crypto_info->cipher_type) {
 =09case TLS_CIPHER_AES_GCM_128: {
 =09=09struct tls12_crypto_info_aes_gcm_128 *gcm_128_info;
=20
-=09=09gcm_128_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_aes_gcm_128);
+=09=09gcm_128_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_AES_GCM_128_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_AES_GCM_128_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_AES_GCM_128_IV_SIZE;
@@ -2701,7 +2733,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_AES_GCM_256: {
 =09=09struct tls12_crypto_info_aes_gcm_256 *gcm_256_info;
=20
-=09=09gcm_256_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_aes_gcm_256);
+=09=09gcm_256_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_AES_GCM_256_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_AES_GCM_256_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_AES_GCM_256_IV_SIZE;
@@ -2718,7 +2751,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_AES_CCM_128: {
 =09=09struct tls12_crypto_info_aes_ccm_128 *ccm_128_info;
=20
-=09=09ccm_128_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_aes_ccm_128);
+=09=09ccm_128_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_AES_CCM_128_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_AES_CCM_128_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_AES_CCM_128_IV_SIZE;
@@ -2735,7 +2769,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_CHACHA20_POLY1305: {
 =09=09struct tls12_crypto_info_chacha20_poly1305 *chacha20_poly1305_info;
=20
-=09=09chacha20_poly1305_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_chacha20_poly13=
05);
+=09=09chacha20_poly1305_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D 0;
 =09=09tag_size =3D TLS_CIPHER_CHACHA20_POLY1305_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_CHACHA20_POLY1305_IV_SIZE;
@@ -2752,7 +2787,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_SM4_GCM: {
 =09=09struct tls12_crypto_info_sm4_gcm *sm4_gcm_info;
=20
-=09=09sm4_gcm_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_sm4_gcm);
+=09=09sm4_gcm_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_SM4_GCM_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_SM4_GCM_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_SM4_GCM_IV_SIZE;
@@ -2769,7 +2805,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_SM4_CCM: {
 =09=09struct tls12_crypto_info_sm4_ccm *sm4_ccm_info;
=20
-=09=09sm4_ccm_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_sm4_ccm);
+=09=09sm4_ccm_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_SM4_CCM_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_SM4_CCM_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_SM4_CCM_IV_SIZE;
@@ -2786,7 +2823,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_ARIA_GCM_128: {
 =09=09struct tls12_crypto_info_aria_gcm_128 *aria_gcm_128_info;
=20
-=09=09aria_gcm_128_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_aria_gcm_128);
+=09=09aria_gcm_128_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_ARIA_GCM_128_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_ARIA_GCM_128_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_ARIA_GCM_128_IV_SIZE;
@@ -2803,7 +2841,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09case TLS_CIPHER_ARIA_GCM_256: {
 =09=09struct tls12_crypto_info_aria_gcm_256 *gcm_256_info;
=20
-=09=09gcm_256_info =3D (void *)crypto_info;
+=09=09crypto_info_size =3D sizeof(struct tls12_crypto_info_aria_gcm_256);
+=09=09gcm_256_info =3D (void *)src_crypto_info;
 =09=09nonce_size =3D TLS_CIPHER_ARIA_GCM_256_IV_SIZE;
 =09=09tag_size =3D TLS_CIPHER_ARIA_GCM_256_TAG_SIZE;
 =09=09iv_size =3D TLS_CIPHER_ARIA_GCM_256_IV_SIZE;
@@ -2847,19 +2886,18 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09=09=09      prot->tag_size + prot->tail_size;
 =09prot->iv_size =3D iv_size;
 =09prot->salt_size =3D salt_size;
-=09cctx->iv =3D kmalloc(iv_size + salt_size, GFP_KERNEL);
-=09if (!cctx->iv) {
-=09=09rc =3D -ENOMEM;
-=09=09goto free_priv;
-=09}
-=09/* Note: 128 & 256 bit salt are the same size */
-=09prot->rec_seq_size =3D rec_seq_size;
-=09memcpy(cctx->iv, salt, salt_size);
-=09memcpy(cctx->iv + salt_size, iv, iv_size);
-=09cctx->rec_seq =3D kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
-=09if (!cctx->rec_seq) {
-=09=09rc =3D -ENOMEM;
-=09=09goto free_iv;
+=09if (!new_crypto_info) {
+=09=09cctx->iv =3D kmalloc(iv_size + salt_size, GFP_KERNEL);
+=09=09if (!cctx->iv) {
+=09=09=09rc =3D -ENOMEM;
+=09=09=09goto free_priv;
+=09=09}
+
+=09=09cctx->rec_seq =3D kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
+=09=09if (!cctx->rec_seq) {
+=09=09=09rc =3D -ENOMEM;
+=09=09=09goto free_iv;
+=09=09}
 =09}
=20
 =09if (!*aead) {
@@ -2873,14 +2911,24 @@ int tls_set_sw_offload(struct sock *sk, int tx)
=20
 =09ctx->push_pending_record =3D tls_sw_push_pending_record;
=20
+=09/* setkey is the last operation that could fail during a
+=09 * rekey. if it succeeds, we can start modifying the
+=09 * context.
+=09 */
 =09rc =3D crypto_aead_setkey(*aead, key, keysize);
+=09if (rc) {
+=09=09if (new_crypto_info)
+=09=09=09goto out;
+=09=09else
+=09=09=09goto free_aead;
+=09}
=20
-=09if (rc)
-=09=09goto free_aead;
-
-=09rc =3D crypto_aead_setauthsize(*aead, prot->tag_size);
-=09if (rc)
-=09=09goto free_aead;
+=09if (!new_crypto_info) {
+=09=09rc =3D crypto_aead_setauthsize(*aead, prot->tag_size);
+=09=09if (rc) {
+=09=09=09goto free_aead;
+=09=09}
+=09}
=20
 =09if (sw_ctx_rx) {
 =09=09tfm =3D crypto_aead_tfm(sw_ctx_rx->aead_recv);
@@ -2895,6 +2943,21 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09=09=09goto free_aead;
 =09}
=20
+=09/* Note: 128 & 256 bit salt are the same size */
+=09prot->rec_seq_size =3D rec_seq_size;
+=09memcpy(cctx->iv, salt, salt_size);
+=09memcpy(cctx->iv + salt_size, iv, iv_size);
+
+=09if (new_crypto_info) {
+=09=09memcpy(cctx->rec_seq, rec_seq, rec_seq_size);
+
+=09=09unsafe_memcpy(crypto_info, new_crypto_info, crypto_info_size,
+=09=09=09      /* size was checked in do_tls_getsockopt_conf */);
+=09=09memzero_explicit(new_crypto_info, crypto_info_size);
+=09=09if (!tx)
+=09=09=09tls_finish_key_update(sk, ctx);
+=09}
+
 =09goto out;
=20
 free_aead:
@@ -2907,12 +2970,14 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09kfree(cctx->iv);
 =09cctx->iv =3D NULL;
 free_priv:
-=09if (tx) {
-=09=09kfree(ctx->priv_ctx_tx);
-=09=09ctx->priv_ctx_tx =3D NULL;
-=09} else {
-=09=09kfree(ctx->priv_ctx_rx);
-=09=09ctx->priv_ctx_rx =3D NULL;
+=09if (!new_crypto_info) {
+=09=09if (tx) {
+=09=09=09kfree(ctx->priv_ctx_tx);
+=09=09=09ctx->priv_ctx_tx =3D NULL;
+=09=09} else {
+=09=09=09kfree(ctx->priv_ctx_rx);
+=09=09=09ctx->priv_ctx_rx =3D NULL;
+=09=09}
 =09}
 out:
 =09return rc;
--=20
2.40.1


