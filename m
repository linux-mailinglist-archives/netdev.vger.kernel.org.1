Return-Path: <netdev+bounces-39308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180517BEBEF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3493B2819C7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32133AC26;
	Mon,  9 Oct 2023 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185283FB19
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:09 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D46D9E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:08 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-HQ16HW5pM2mV9iY9qUWDGw-1; Mon, 09 Oct 2023 16:51:04 -0400
X-MC-Unique: HQ16HW5pM2mV9iY9qUWDGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37F053C00086;
	Mon,  9 Oct 2023 20:51:04 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36ECC36E1;
	Mon,  9 Oct 2023 20:51:03 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 05/14] tls: store iv directly within cipher_context
Date: Mon,  9 Oct 2023 22:50:45 +0200
Message-ID: <69c87cb18df8fe6c857d88fd56aed9adae08ffdc.1696596130.git.sd@queasysnail.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE is 20B, we don't get much benefit
in cipher_context's size and can simplify the init code a bit.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h    |  3 ++-
 net/tls/tls_device.c | 13 ++-----------
 net/tls/tls_main.c   |  2 +-
 net/tls/tls_sw.c     | 13 ++-----------
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 5200ce27db91..28cc40d7b945 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -62,6 +62,7 @@ struct tls_rec;
 #define TLS_AAD_SPACE_SIZE=09=0913
=20
 #define TLS_MAX_IV_SIZE=09=09=0916
+#define TLS_MAX_SALT_SIZE=09=094
 #define TLS_TAG_SIZE=09=09=0916
 #define TLS_MAX_REC_SEQ_SIZE=09=098
 #define TLS_MAX_AAD_SIZE=09=09TLS_AAD_SPACE_SIZE
@@ -193,7 +194,7 @@ enum tls_context_flags {
 };
=20
 struct cipher_context {
-=09char *iv;
+=09char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
 =09char rec_seq[TLS_MAX_REC_SEQ_SIZE];
 };
=20
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 525d7b813869..0981496c6294 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -56,10 +56,8 @@ static struct page *dummy_page;
=20
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
-=09if (ctx->tx_conf =3D=3D TLS_HW) {
+=09if (ctx->tx_conf =3D=3D TLS_HW)
 =09=09kfree(tls_offload_ctx_tx(ctx));
-=09=09kfree(ctx->tx.iv);
-=09}
=20
 =09if (ctx->rx_conf =3D=3D TLS_HW)
 =09=09kfree(tls_offload_ctx_rx(ctx));
@@ -1088,11 +1086,6 @@ int tls_set_device_offload(struct sock *sk, struct t=
ls_context *ctx)
 =09prot->overhead_size =3D prot->prepend_size + prot->tag_size;
 =09prot->iv_size =3D cipher_desc->iv;
 =09prot->salt_size =3D cipher_desc->salt;
-=09ctx->tx.iv =3D kmalloc(cipher_desc->iv + cipher_desc->salt, GFP_KERNEL)=
;
-=09if (!ctx->tx.iv) {
-=09=09rc =3D -ENOMEM;
-=09=09goto release_netdev;
-=09}
=20
 =09memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
=20
@@ -1102,7 +1095,7 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 =09start_marker_record =3D kmalloc(sizeof(*start_marker_record), GFP_KERNE=
L);
 =09if (!start_marker_record) {
 =09=09rc =3D -ENOMEM;
-=09=09goto free_iv;
+=09=09goto release_netdev;
 =09}
=20
 =09offload_ctx =3D kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);
@@ -1187,8 +1180,6 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 =09ctx->priv_ctx_tx =3D NULL;
 free_marker_record:
 =09kfree(start_marker_record);
-free_iv:
-=09kfree(ctx->tx.iv);
 release_netdev:
 =09dev_put(netdev);
 =09return rc;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 58f13660fe6b..b91524ac1009 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -60,6 +60,7 @@ enum {
=20
 #define CHECK_CIPHER_DESC(cipher,ci)=09=09=09=09\
 =09static_assert(cipher ## _IV_SIZE <=3D TLS_MAX_IV_SIZE);=09=09\
+=09static_assert(cipher ## _SALT_SIZE <=3D TLS_MAX_SALT_SIZE);=09=09\
 =09static_assert(cipher ## _REC_SEQ_SIZE <=3D TLS_MAX_REC_SEQ_SIZE);=09\
 =09static_assert(cipher ## _TAG_SIZE =3D=3D TLS_TAG_SIZE);=09=09\
 =09static_assert(sizeof_field(struct ci, iv) =3D=3D cipher ## _IV_SIZE);=
=09\
@@ -344,7 +345,6 @@ static void tls_sk_proto_cleanup(struct sock *sk,
=20
 =09/* We need these for tls_sw_fallback handling of other packets */
 =09if (ctx->tx_conf =3D=3D TLS_SW) {
-=09=09kfree(ctx->tx.iv);
 =09=09tls_sw_release_resources_tx(sk);
 =09=09TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
 =09} else if (ctx->tx_conf =3D=3D TLS_HW) {
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5b6175f9b9a6..c3da937b8207 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2467,8 +2467,6 @@ void tls_sw_release_resources_rx(struct sock *sk)
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
 =09struct tls_sw_context_rx *ctx =3D tls_sw_ctx_rx(tls_ctx);
=20
-=09kfree(tls_ctx->rx.iv);
-
 =09if (ctx->aead_recv) {
 =09=09__skb_queue_purge(&ctx->rx_list);
 =09=09crypto_free_aead(ctx->aead_recv);
@@ -2682,11 +2680,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_c=
ontext *ctx, int tx)
 =09=09=09      prot->tag_size + prot->tail_size;
 =09prot->iv_size =3D cipher_desc->iv;
 =09prot->salt_size =3D cipher_desc->salt;
-=09cctx->iv =3D kmalloc(cipher_desc->iv + cipher_desc->salt, GFP_KERNEL);
-=09if (!cctx->iv) {
-=09=09rc =3D -ENOMEM;
-=09=09goto free_priv;
-=09}
+
 =09/* Note: 128 & 256 bit salt are the same size */
 =09prot->rec_seq_size =3D cipher_desc->rec_seq;
 =09memcpy(cctx->iv, salt, cipher_desc->salt);
@@ -2698,7 +2692,7 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 =09=09if (IS_ERR(*aead)) {
 =09=09=09rc =3D PTR_ERR(*aead);
 =09=09=09*aead =3D NULL;
-=09=09=09goto free_iv;
+=09=09=09goto free_priv;
 =09=09}
 =09}
=20
@@ -2730,9 +2724,6 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 free_aead:
 =09crypto_free_aead(*aead);
 =09*aead =3D NULL;
-free_iv:
-=09kfree(cctx->iv);
-=09cctx->iv =3D NULL;
 free_priv:
 =09if (tx) {
 =09=09kfree(ctx->priv_ctx_tx);
--=20
2.42.0


