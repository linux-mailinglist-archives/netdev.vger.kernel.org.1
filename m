Return-Path: <netdev+bounces-30785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10E789093
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCC01C20F99
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531C1988E;
	Fri, 25 Aug 2023 21:37:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D919882
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:37:59 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E5C2D46
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:37:31 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-Bcuol6BNOSCGp47LrDo_-g-1; Fri, 25 Aug 2023 17:37:06 -0400
X-MC-Unique: Bcuol6BNOSCGp47LrDo_-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18151185A792;
	Fri, 25 Aug 2023 21:37:06 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4977C1678B;
	Fri, 25 Aug 2023 21:37:05 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 14/17] tls: use tls_cipher_desc to simplify do_tls_getsockopt_conf
Date: Fri, 25 Aug 2023 23:35:19 +0200
Message-Id: <c21a904b91e972bdbbf9d1c6d2731ccfa1eedf72.1692977948.git.sd@queasysnail.net>
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

Every cipher uses the same code to update its crypto_info struct based
on the values contained in the cctx, with only the struct type and
size/offset changing. We can get those  from tls_cipher_desc, and use
a single pair of memcpy and final copy_to_user.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 174 +++------------------------------------------
 1 file changed, 11 insertions(+), 163 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 73cae5dec392..02f583ff9239 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -435,6 +435,7 @@ static int do_tls_getsockopt_conf(struct sock *sk, char=
 __user *optval,
 =09=09=09=09  int __user *optlen, int tx)
 {
 =09int rc =3D 0;
+=09const struct tls_cipher_desc *cipher_desc;
 =09struct tls_context *ctx =3D tls_get_ctx(sk);
 =09struct tls_crypto_info *crypto_info;
 =09struct cipher_context *cctx;
@@ -473,172 +474,19 @@ static int do_tls_getsockopt_conf(struct sock *sk, c=
har __user *optval,
 =09=09goto out;
 =09}
=20
-=09switch (crypto_info->cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128: {
-=09=09struct tls12_crypto_info_aes_gcm_128 *
-=09=09  crypto_info_aes_gcm_128 =3D
-=09=09  container_of(crypto_info,
-=09=09=09       struct tls12_crypto_info_aes_gcm_128,
-=09=09=09       info);
-
-=09=09if (len !=3D sizeof(*crypto_info_aes_gcm_128)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(crypto_info_aes_gcm_128->iv,
-=09=09       cctx->iv + TLS_CIPHER_AES_GCM_128_SALT_SIZE,
-=09=09       TLS_CIPHER_AES_GCM_128_IV_SIZE);
-=09=09memcpy(crypto_info_aes_gcm_128->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval,
-=09=09=09=09 crypto_info_aes_gcm_128,
-=09=09=09=09 sizeof(*crypto_info_aes_gcm_128)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09case TLS_CIPHER_AES_GCM_256: {
-=09=09struct tls12_crypto_info_aes_gcm_256 *
-=09=09  crypto_info_aes_gcm_256 =3D
-=09=09  container_of(crypto_info,
-=09=09=09       struct tls12_crypto_info_aes_gcm_256,
-=09=09=09       info);
-
-=09=09if (len !=3D sizeof(*crypto_info_aes_gcm_256)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(crypto_info_aes_gcm_256->iv,
-=09=09       cctx->iv + TLS_CIPHER_AES_GCM_256_SALT_SIZE,
-=09=09       TLS_CIPHER_AES_GCM_256_IV_SIZE);
-=09=09memcpy(crypto_info_aes_gcm_256->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_AES_GCM_256_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval,
-=09=09=09=09 crypto_info_aes_gcm_256,
-=09=09=09=09 sizeof(*crypto_info_aes_gcm_256)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09case TLS_CIPHER_AES_CCM_128: {
-=09=09struct tls12_crypto_info_aes_ccm_128 *aes_ccm_128 =3D
-=09=09=09container_of(crypto_info,
-=09=09=09=09struct tls12_crypto_info_aes_ccm_128, info);
-
-=09=09if (len !=3D sizeof(*aes_ccm_128)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(aes_ccm_128->iv,
-=09=09       cctx->iv + TLS_CIPHER_AES_CCM_128_SALT_SIZE,
-=09=09       TLS_CIPHER_AES_CCM_128_IV_SIZE);
-=09=09memcpy(aes_ccm_128->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_AES_CCM_128_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval, aes_ccm_128, sizeof(*aes_ccm_128)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09case TLS_CIPHER_CHACHA20_POLY1305: {
-=09=09struct tls12_crypto_info_chacha20_poly1305 *chacha20_poly1305 =3D
-=09=09=09container_of(crypto_info,
-=09=09=09=09struct tls12_crypto_info_chacha20_poly1305,
-=09=09=09=09info);
-
-=09=09if (len !=3D sizeof(*chacha20_poly1305)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(chacha20_poly1305->iv,
-=09=09       cctx->iv + TLS_CIPHER_CHACHA20_POLY1305_SALT_SIZE,
-=09=09       TLS_CIPHER_CHACHA20_POLY1305_IV_SIZE);
-=09=09memcpy(chacha20_poly1305->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_CHACHA20_POLY1305_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval, chacha20_poly1305,
-=09=09=09=09sizeof(*chacha20_poly1305)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
+=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
+=09if (!cipher_desc || len !=3D cipher_desc->crypto_info) {
+=09=09rc =3D -EINVAL;
+=09=09goto out;
 =09}
-=09case TLS_CIPHER_SM4_GCM: {
-=09=09struct tls12_crypto_info_sm4_gcm *sm4_gcm_info =3D
-=09=09=09container_of(crypto_info,
-=09=09=09=09struct tls12_crypto_info_sm4_gcm, info);
=20
-=09=09if (len !=3D sizeof(*sm4_gcm_info)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(sm4_gcm_info->iv,
-=09=09       cctx->iv + TLS_CIPHER_SM4_GCM_SALT_SIZE,
-=09=09       TLS_CIPHER_SM4_GCM_IV_SIZE);
-=09=09memcpy(sm4_gcm_info->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_SM4_GCM_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval, sm4_gcm_info, sizeof(*sm4_gcm_info)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09case TLS_CIPHER_SM4_CCM: {
-=09=09struct tls12_crypto_info_sm4_ccm *sm4_ccm_info =3D
-=09=09=09container_of(crypto_info,
-=09=09=09=09struct tls12_crypto_info_sm4_ccm, info);
+=09memcpy(crypto_info_iv(crypto_info, cipher_desc),
+=09       cctx->iv + cipher_desc->salt, cipher_desc->iv);
+=09memcpy(crypto_info_rec_seq(crypto_info, cipher_desc),
+=09       cctx->rec_seq, cipher_desc->rec_seq);
=20
-=09=09if (len !=3D sizeof(*sm4_ccm_info)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(sm4_ccm_info->iv,
-=09=09       cctx->iv + TLS_CIPHER_SM4_CCM_SALT_SIZE,
-=09=09       TLS_CIPHER_SM4_CCM_IV_SIZE);
-=09=09memcpy(sm4_ccm_info->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_SM4_CCM_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval, sm4_ccm_info, sizeof(*sm4_ccm_info)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09case TLS_CIPHER_ARIA_GCM_128: {
-=09=09struct tls12_crypto_info_aria_gcm_128 *
-=09=09  crypto_info_aria_gcm_128 =3D
-=09=09  container_of(crypto_info,
-=09=09=09       struct tls12_crypto_info_aria_gcm_128,
-=09=09=09       info);
-
-=09=09if (len !=3D sizeof(*crypto_info_aria_gcm_128)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(crypto_info_aria_gcm_128->iv,
-=09=09       cctx->iv + TLS_CIPHER_ARIA_GCM_128_SALT_SIZE,
-=09=09       TLS_CIPHER_ARIA_GCM_128_IV_SIZE);
-=09=09memcpy(crypto_info_aria_gcm_128->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_ARIA_GCM_128_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval,
-=09=09=09=09 crypto_info_aria_gcm_128,
-=09=09=09=09 sizeof(*crypto_info_aria_gcm_128)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09case TLS_CIPHER_ARIA_GCM_256: {
-=09=09struct tls12_crypto_info_aria_gcm_256 *
-=09=09  crypto_info_aria_gcm_256 =3D
-=09=09  container_of(crypto_info,
-=09=09=09       struct tls12_crypto_info_aria_gcm_256,
-=09=09=09       info);
-
-=09=09if (len !=3D sizeof(*crypto_info_aria_gcm_256)) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto out;
-=09=09}
-=09=09memcpy(crypto_info_aria_gcm_256->iv,
-=09=09       cctx->iv + TLS_CIPHER_ARIA_GCM_256_SALT_SIZE,
-=09=09       TLS_CIPHER_ARIA_GCM_256_IV_SIZE);
-=09=09memcpy(crypto_info_aria_gcm_256->rec_seq, cctx->rec_seq,
-=09=09       TLS_CIPHER_ARIA_GCM_256_REC_SEQ_SIZE);
-=09=09if (copy_to_user(optval,
-=09=09=09=09 crypto_info_aria_gcm_256,
-=09=09=09=09 sizeof(*crypto_info_aria_gcm_256)))
-=09=09=09rc =3D -EFAULT;
-=09=09break;
-=09}
-=09default:
-=09=09rc =3D -EINVAL;
-=09}
+=09if (copy_to_user(optval, crypto_info, cipher_desc->crypto_info))
+=09=09rc =3D -EFAULT;
=20
 out:
 =09return rc;
--=20
2.40.1


