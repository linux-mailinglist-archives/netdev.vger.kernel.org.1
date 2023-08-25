Return-Path: <netdev+bounces-30784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338C789089
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59071C2100D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723B198B4;
	Fri, 25 Aug 2023 21:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5111BF0A
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:37:48 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E62701
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:37:16 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-BcJ-ZCYjNfS0cAsIFusFZA-1; Fri, 25 Aug 2023 17:36:56 -0400
X-MC-Unique: BcJ-ZCYjNfS0cAsIFusFZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B67B3815EE1;
	Fri, 25 Aug 2023 21:36:56 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CADC5CC06;
	Fri, 25 Aug 2023 21:36:55 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 13/17] tls: get crypto_info size from tls_cipher_desc in do_tls_setsockopt_conf
Date: Fri, 25 Aug 2023 23:35:18 +0200
Message-Id: <e97658eb4c6a5832f8ba20a06c4f36a77763c59e.1692977948.git.sd@queasysnail.net>
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

We can simplify do_tls_setsockopt_conf using tls_cipher_desc. Also use
get_cipher_desc's result to check if the cipher_type coming from
userspace is valid.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9d8629be7017..73cae5dec392 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -739,7 +739,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09struct tls_crypto_info *crypto_info;
 =09struct tls_crypto_info *alt_crypto_info;
 =09struct tls_context *ctx =3D tls_get_ctx(sk);
-=09size_t optsize;
+=09const struct tls_cipher_desc *cipher_desc;
 =09int rc =3D 0;
 =09int conf;
=20
@@ -780,46 +780,23 @@ static int do_tls_setsockopt_conf(struct sock *sk, so=
ckptr_t optval,
 =09=09}
 =09}
=20
-=09switch (crypto_info->cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128:
-=09=09optsize =3D sizeof(struct tls12_crypto_info_aes_gcm_128);
-=09=09break;
-=09case TLS_CIPHER_AES_GCM_256: {
-=09=09optsize =3D sizeof(struct tls12_crypto_info_aes_gcm_256);
-=09=09break;
+=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
+=09if (!cipher_desc) {
+=09=09rc =3D -EINVAL;
+=09=09goto err_crypto_info;
 =09}
-=09case TLS_CIPHER_AES_CCM_128:
-=09=09optsize =3D sizeof(struct tls12_crypto_info_aes_ccm_128);
-=09=09break;
-=09case TLS_CIPHER_CHACHA20_POLY1305:
-=09=09optsize =3D sizeof(struct tls12_crypto_info_chacha20_poly1305);
-=09=09break;
-=09case TLS_CIPHER_SM4_GCM:
-=09=09optsize =3D sizeof(struct tls12_crypto_info_sm4_gcm);
-=09=09break;
-=09case TLS_CIPHER_SM4_CCM:
-=09=09optsize =3D sizeof(struct tls12_crypto_info_sm4_ccm);
-=09=09break;
+
+=09switch (crypto_info->cipher_type) {
 =09case TLS_CIPHER_ARIA_GCM_128:
-=09=09if (crypto_info->version !=3D TLS_1_2_VERSION) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto err_crypto_info;
-=09=09}
-=09=09optsize =3D sizeof(struct tls12_crypto_info_aria_gcm_128);
-=09=09break;
 =09case TLS_CIPHER_ARIA_GCM_256:
 =09=09if (crypto_info->version !=3D TLS_1_2_VERSION) {
 =09=09=09rc =3D -EINVAL;
 =09=09=09goto err_crypto_info;
 =09=09}
-=09=09optsize =3D sizeof(struct tls12_crypto_info_aria_gcm_256);
 =09=09break;
-=09default:
-=09=09rc =3D -EINVAL;
-=09=09goto err_crypto_info;
 =09}
=20
-=09if (optlen !=3D optsize) {
+=09if (optlen !=3D cipher_desc->crypto_info) {
 =09=09rc =3D -EINVAL;
 =09=09goto err_crypto_info;
 =09}
--=20
2.40.1


