Return-Path: <netdev+bounces-30787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EAC789096
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612C0280A00
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A3C1D305;
	Fri, 25 Aug 2023 21:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCB1AA76
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:38:03 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0363D2691
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:37:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-1x32Rd8pOMe7MPO732tw7w-1; Fri, 25 Aug 2023 17:37:24 -0400
X-MC-Unique: 1x32Rd8pOMe7MPO732tw7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14EAD3C100A7;
	Fri, 25 Aug 2023 21:37:24 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 471EF6B59A;
	Fri, 25 Aug 2023 21:37:23 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 16/17] tls: use tls_cipher_desc to access per-cipher crypto_info in tls_set_sw_offload
Date: Fri, 25 Aug 2023 23:35:21 +0200
Message-Id: <c23af110caf0af6b68de2f86c58064913e2e902a.1692977948.git.sd@queasysnail.net>
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

The crypto_info_* helpers allow us to fetch pointers into the
per-cipher crypto_info's data.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 89 +++++++-----------------------------------------
 1 file changed, 13 insertions(+), 76 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 85708656dcd4..9c18ddf0d568 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2648,94 +2648,26 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09}
=20
 =09switch (crypto_info->cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128: {
-=09=09struct tls12_crypto_info_aes_gcm_128 *gcm_128_info;
-
-=09=09gcm_128_info =3D (void *)crypto_info;
-=09=09iv =3D gcm_128_info->iv;
-=09=09rec_seq =3D gcm_128_info->rec_seq;
-=09=09key =3D gcm_128_info->key;
-=09=09salt =3D gcm_128_info->salt;
+=09case TLS_CIPHER_AES_GCM_128:
+=09case TLS_CIPHER_AES_GCM_256:
 =09=09cipher_name =3D "gcm(aes)";
 =09=09break;
-=09}
-=09case TLS_CIPHER_AES_GCM_256: {
-=09=09struct tls12_crypto_info_aes_gcm_256 *gcm_256_info;
-
-=09=09gcm_256_info =3D (void *)crypto_info;
-=09=09iv =3D gcm_256_info->iv;
-=09=09rec_seq =3D gcm_256_info->rec_seq;
-=09=09key =3D gcm_256_info->key;
-=09=09salt =3D gcm_256_info->salt;
-=09=09cipher_name =3D "gcm(aes)";
-=09=09break;
-=09}
-=09case TLS_CIPHER_AES_CCM_128: {
-=09=09struct tls12_crypto_info_aes_ccm_128 *ccm_128_info;
-
-=09=09ccm_128_info =3D (void *)crypto_info;
-=09=09iv =3D ccm_128_info->iv;
-=09=09rec_seq =3D ccm_128_info->rec_seq;
-=09=09key =3D ccm_128_info->key;
-=09=09salt =3D ccm_128_info->salt;
+=09case TLS_CIPHER_AES_CCM_128:
 =09=09cipher_name =3D "ccm(aes)";
 =09=09break;
-=09}
-=09case TLS_CIPHER_CHACHA20_POLY1305: {
-=09=09struct tls12_crypto_info_chacha20_poly1305 *chacha20_poly1305_info;
-
-=09=09chacha20_poly1305_info =3D (void *)crypto_info;
-=09=09iv =3D chacha20_poly1305_info->iv;
-=09=09rec_seq =3D chacha20_poly1305_info->rec_seq;
-=09=09key =3D chacha20_poly1305_info->key;
-=09=09salt =3D chacha20_poly1305_info->salt;
+=09case TLS_CIPHER_CHACHA20_POLY1305:
 =09=09cipher_name =3D "rfc7539(chacha20,poly1305)";
 =09=09break;
-=09}
-=09case TLS_CIPHER_SM4_GCM: {
-=09=09struct tls12_crypto_info_sm4_gcm *sm4_gcm_info;
-
-=09=09sm4_gcm_info =3D (void *)crypto_info;
-=09=09iv =3D sm4_gcm_info->iv;
-=09=09rec_seq =3D sm4_gcm_info->rec_seq;
-=09=09key =3D sm4_gcm_info->key;
-=09=09salt =3D sm4_gcm_info->salt;
+=09case TLS_CIPHER_SM4_GCM:
 =09=09cipher_name =3D "gcm(sm4)";
 =09=09break;
-=09}
-=09case TLS_CIPHER_SM4_CCM: {
-=09=09struct tls12_crypto_info_sm4_ccm *sm4_ccm_info;
-
-=09=09sm4_ccm_info =3D (void *)crypto_info;
-=09=09iv =3D sm4_ccm_info->iv;
-=09=09rec_seq =3D sm4_ccm_info->rec_seq;
-=09=09key =3D sm4_ccm_info->key;
-=09=09salt =3D sm4_ccm_info->salt;
+=09case TLS_CIPHER_SM4_CCM:
 =09=09cipher_name =3D "ccm(sm4)";
 =09=09break;
-=09}
-=09case TLS_CIPHER_ARIA_GCM_128: {
-=09=09struct tls12_crypto_info_aria_gcm_128 *aria_gcm_128_info;
-
-=09=09aria_gcm_128_info =3D (void *)crypto_info;
-=09=09iv =3D aria_gcm_128_info->iv;
-=09=09rec_seq =3D aria_gcm_128_info->rec_seq;
-=09=09key =3D aria_gcm_128_info->key;
-=09=09salt =3D aria_gcm_128_info->salt;
+=09case TLS_CIPHER_ARIA_GCM_128:
+=09case TLS_CIPHER_ARIA_GCM_256:
 =09=09cipher_name =3D "gcm(aria)";
 =09=09break;
-=09}
-=09case TLS_CIPHER_ARIA_GCM_256: {
-=09=09struct tls12_crypto_info_aria_gcm_256 *gcm_256_info;
-
-=09=09gcm_256_info =3D (void *)crypto_info;
-=09=09iv =3D gcm_256_info->iv;
-=09=09rec_seq =3D gcm_256_info->rec_seq;
-=09=09key =3D gcm_256_info->key;
-=09=09salt =3D gcm_256_info->salt;
-=09=09cipher_name =3D "gcm(aria)";
-=09=09break;
-=09}
 =09default:
 =09=09rc =3D -EINVAL;
 =09=09goto free_priv;
@@ -2744,6 +2676,11 @@ int tls_set_sw_offload(struct sock *sk, struct tls_c=
ontext *ctx, int tx)
 =09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
 =09nonce_size =3D cipher_desc->nonce;
=20
+=09iv =3D crypto_info_iv(crypto_info, cipher_desc);
+=09key =3D crypto_info_key(crypto_info, cipher_desc);
+=09salt =3D crypto_info_salt(crypto_info, cipher_desc);
+=09rec_seq =3D crypto_info_rec_seq(crypto_info, cipher_desc);
+
 =09if (crypto_info->version =3D=3D TLS_1_3_VERSION) {
 =09=09nonce_size =3D 0;
 =09=09prot->aad_size =3D TLS_HEADER_SIZE;
--=20
2.40.1


