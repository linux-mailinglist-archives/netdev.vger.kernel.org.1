Return-Path: <netdev+bounces-30782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CE789083
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C9C28196A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA01988A;
	Fri, 25 Aug 2023 21:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B3193AC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:37:36 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6012710
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:37:06 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-A4nAM8mePACaajYD9bElxg-1; Fri, 25 Aug 2023 17:36:47 -0400
X-MC-Unique: A4nAM8mePACaajYD9bElxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A0648030AC;
	Fri, 25 Aug 2023 21:36:47 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2865CC06;
	Fri, 25 Aug 2023 21:36:46 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 11/17] tls: allocate the fallback aead after checking that the cipher is valid
Date: Fri, 25 Aug 2023 23:35:16 +0200
Message-Id: <335e32511ed55a0b30f3f81a78fa8f323b3bdf8f.1692977948.git.sd@queasysnail.net>
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

No need to allocate the aead if we're going to fail afterwards.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_device_fallback.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index cb224fb2a394..4de9061f38f5 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -475,15 +475,6 @@ int tls_sw_fallback_init(struct sock *sk,
 =09const u8 *key;
 =09int rc;
=20
-=09offload_ctx->aead_send =3D
-=09    crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
-=09if (IS_ERR(offload_ctx->aead_send)) {
-=09=09rc =3D PTR_ERR(offload_ctx->aead_send);
-=09=09pr_err_ratelimited("crypto_alloc_aead failed rc=3D%d\n", rc);
-=09=09offload_ctx->aead_send =3D NULL;
-=09=09goto err_out;
-=09}
-
 =09switch (crypto_info->cipher_type) {
 =09case TLS_CIPHER_AES_GCM_128:
 =09=09key =3D ((struct tls12_crypto_info_aes_gcm_128 *)crypto_info)->key;
@@ -493,10 +484,19 @@ int tls_sw_fallback_init(struct sock *sk,
 =09=09break;
 =09default:
 =09=09rc =3D -EINVAL;
-=09=09goto free_aead;
+=09=09goto err_out;
 =09}
 =09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
=20
+=09offload_ctx->aead_send =3D
+=09    crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+=09if (IS_ERR(offload_ctx->aead_send)) {
+=09=09rc =3D PTR_ERR(offload_ctx->aead_send);
+=09=09pr_err_ratelimited("crypto_alloc_aead failed rc=3D%d\n", rc);
+=09=09offload_ctx->aead_send =3D NULL;
+=09=09goto err_out;
+=09}
+
 =09rc =3D crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key=
);
 =09if (rc)
 =09=09goto free_aead;
--=20
2.40.1


