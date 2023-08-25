Return-Path: <netdev+bounces-30788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC68789097
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973FF280A00
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAE11AA7C;
	Fri, 25 Aug 2023 21:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C921DDDD
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:38:05 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B326BF
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:37:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Ef8IAmJJNOGGZVw5GeaN6g-1; Fri, 25 Aug 2023 17:37:32 -0400
X-MC-Unique: Ef8IAmJJNOGGZVw5GeaN6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76D1685C713;
	Fri, 25 Aug 2023 21:37:31 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3B406B2B4;
	Fri, 25 Aug 2023 21:37:30 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 17/17] tls: get cipher_name from cipher_desc in tls_set_sw_offload
Date: Fri, 25 Aug 2023 23:35:22 +0200
Message-Id: <53d021d80138aa125a9cef4468aa5ce531975a7b.1692977948.git.sd@queasysnail.net>
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

tls_cipher_desc also contains the algorithm name needed by
crypto_alloc_aead, use it.

Finally, use get_cipher_desc to check if the cipher_type coming from
userspace is valid, and remove the cipher_type switch.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9c18ddf0d568..1ed4a611631f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2591,7 +2591,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09struct cipher_context *cctx;
 =09struct crypto_aead **aead;
 =09struct crypto_tfm *tfm;
-=09char *iv, *rec_seq, *key, *salt, *cipher_name;
+=09char *iv, *rec_seq, *key, *salt;
 =09const struct tls_cipher_desc *cipher_desc;
 =09u16 nonce_size;
 =09int rc =3D 0;
@@ -2647,33 +2647,12 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09=09aead =3D &sw_ctx_rx->aead_recv;
 =09}
=20
-=09switch (crypto_info->cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128:
-=09case TLS_CIPHER_AES_GCM_256:
-=09=09cipher_name =3D "gcm(aes)";
-=09=09break;
-=09case TLS_CIPHER_AES_CCM_128:
-=09=09cipher_name =3D "ccm(aes)";
-=09=09break;
-=09case TLS_CIPHER_CHACHA20_POLY1305:
-=09=09cipher_name =3D "rfc7539(chacha20,poly1305)";
-=09=09break;
-=09case TLS_CIPHER_SM4_GCM:
-=09=09cipher_name =3D "gcm(sm4)";
-=09=09break;
-=09case TLS_CIPHER_SM4_CCM:
-=09=09cipher_name =3D "ccm(sm4)";
-=09=09break;
-=09case TLS_CIPHER_ARIA_GCM_128:
-=09case TLS_CIPHER_ARIA_GCM_256:
-=09=09cipher_name =3D "gcm(aria)";
-=09=09break;
-=09default:
+=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
+=09if (!cipher_desc) {
 =09=09rc =3D -EINVAL;
 =09=09goto free_priv;
 =09}
=20
-=09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
 =09nonce_size =3D cipher_desc->nonce;
=20
 =09iv =3D crypto_info_iv(crypto_info, cipher_desc);
@@ -2721,7 +2700,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09}
=20
 =09if (!*aead) {
-=09=09*aead =3D crypto_alloc_aead(cipher_name, 0, 0);
+=09=09*aead =3D crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
 =09=09if (IS_ERR(*aead)) {
 =09=09=09rc =3D PTR_ERR(*aead);
 =09=09=09*aead =3D NULL;
--=20
2.40.1


