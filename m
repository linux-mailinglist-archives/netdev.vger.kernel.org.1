Return-Path: <netdev+bounces-39319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD417BEBFA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A8A281E37
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1E405F1;
	Mon,  9 Oct 2023 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC86405C5
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:39 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F83C5
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:37 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-6M0Uj3i3Oj29qNS6dbLYrA-1; Mon, 09 Oct 2023 16:51:08 -0400
X-MC-Unique: 6M0Uj3i3Oj29qNS6dbLYrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1045F802C1A;
	Mon,  9 Oct 2023 20:51:08 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 100FE36E1;
	Mon,  9 Oct 2023 20:51:06 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 08/14] tls: also use init_prot_info in tls_set_device_offload
Date: Mon,  9 Oct 2023 22:50:48 +0200
Message-ID: <6da95c0d469415ee62cc23ce72227f8d058400bc.1696596130.git.sd@queasysnail.net>
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

Most values are shared. Nonce size turns out to be equal to IV size
for all offloadable ciphers.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |  4 ++++
 net/tls/tls_device.c | 14 ++++----------
 net/tls/tls_sw.c     | 14 ++++++++++----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 16830aa2d6ec..756ed6cbc3df 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -142,6 +142,10 @@ void update_sk_prot(struct sock *sk, struct tls_contex=
t *ctx);
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
=20
+int init_prot_info(struct tls_prot_info *prot,
+=09=09   const struct tls_crypto_info *crypto_info,
+=09=09   const struct tls_cipher_desc *cipher_desc,
+=09=09   int mode);
 int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 0981496c6294..3d73dd97e903 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1076,20 +1076,14 @@ int tls_set_device_offload(struct sock *sk, struct =
tls_context *ctx)
 =09=09goto release_netdev;
 =09}
=20
+=09rc =3D init_prot_info(prot, crypto_info, cipher_desc, TLS_HW);
+=09if (rc)
+=09=09goto release_netdev;
+
 =09iv =3D crypto_info_iv(crypto_info, cipher_desc);
 =09rec_seq =3D crypto_info_rec_seq(crypto_info, cipher_desc);
=20
-=09prot->version =3D crypto_info->version;
-=09prot->cipher_type =3D crypto_info->cipher_type;
-=09prot->prepend_size =3D TLS_HEADER_SIZE + cipher_desc->iv;
-=09prot->tag_size =3D cipher_desc->tag;
-=09prot->overhead_size =3D prot->prepend_size + prot->tag_size;
-=09prot->iv_size =3D cipher_desc->iv;
-=09prot->salt_size =3D cipher_desc->salt;
-
 =09memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
-
-=09prot->rec_seq_size =3D cipher_desc->rec_seq;
 =09memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
=20
 =09start_marker_record =3D kmalloc(sizeof(*start_marker_record), GFP_KERNE=
L);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index b8e89bbb4a49..0995d3d14f4b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2620,9 +2620,10 @@ static struct tls_sw_context_rx *init_ctx_rx(struct =
tls_context *ctx)
 =09return sw_ctx_rx;
 }
=20
-static int init_prot_info(struct tls_prot_info *prot,
-=09=09=09  const struct tls_crypto_info *crypto_info,
-=09=09=09  const struct tls_cipher_desc *cipher_desc)
+int init_prot_info(struct tls_prot_info *prot,
+=09=09   const struct tls_crypto_info *crypto_info,
+=09=09   const struct tls_cipher_desc *cipher_desc,
+=09=09   int mode)
 {
 =09u16 nonce_size =3D cipher_desc->nonce;
=20
@@ -2635,6 +2636,11 @@ static int init_prot_info(struct tls_prot_info *prot=
,
 =09=09prot->tail_size =3D 0;
 =09}
=20
+=09if (mode =3D=3D TLS_HW) {
+=09=09prot->aad_size =3D 0;
+=09=09prot->tail_size =3D 0;
+=09}
+
 =09/* Sanity-check the sizes for stack allocations. */
 =09if (nonce_size > TLS_MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE)
 =09=09return -EINVAL;
@@ -2696,7 +2702,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09=09goto free_priv;
 =09}
=20
-=09rc =3D init_prot_info(prot, crypto_info, cipher_desc);
+=09rc =3D init_prot_info(prot, crypto_info, cipher_desc, TLS_SW);
 =09if (rc)
 =09=09goto free_priv;
=20
--=20
2.42.0


