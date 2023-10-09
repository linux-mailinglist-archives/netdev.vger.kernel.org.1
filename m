Return-Path: <netdev+bounces-39313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDDD7BEBF4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA161C20C85
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB03FB15;
	Mon,  9 Oct 2023 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B41F19D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:22 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7ADA7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:20 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-ONBsNVKPP4qhMoI2kFqDJQ-1; Mon, 09 Oct 2023 16:51:06 -0400
X-MC-Unique: ONBsNVKPP4qhMoI2kFqDJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D37F3822E8C;
	Mon,  9 Oct 2023 20:51:05 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC7336E1;
	Mon,  9 Oct 2023 20:51:04 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 06/14] tls: extract context alloc/initialization out of tls_set_sw_offload
Date: Mon,  9 Oct 2023 22:50:46 +0200
Message-ID: <a2c88b487f2a7c74006d5a1c60a1424b5ee085ed.1696596130.git.sd@queasysnail.net>
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

Simplify tls_set_sw_offload a bit.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 86 ++++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index c3da937b8207..b5428f543d17 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2578,6 +2578,48 @@ void tls_update_rx_zc_capable(struct tls_context *tl=
s_ctx)
 =09=09tls_ctx->prot_info.version !=3D TLS_1_3_VERSION;
 }
=20
+static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, stru=
ct sock *sk)
+{
+=09struct tls_sw_context_tx *sw_ctx_tx;
+
+=09if (!ctx->priv_ctx_tx) {
+=09=09sw_ctx_tx =3D kzalloc(sizeof(*sw_ctx_tx), GFP_KERNEL);
+=09=09if (!sw_ctx_tx)
+=09=09=09return NULL;
+=09} else {
+=09=09sw_ctx_tx =3D ctx->priv_ctx_tx;
+=09}
+
+=09crypto_init_wait(&sw_ctx_tx->async_wait);
+=09spin_lock_init(&sw_ctx_tx->encrypt_compl_lock);
+=09INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
+=09INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
+=09sw_ctx_tx->tx_work.sk =3D sk;
+
+=09return sw_ctx_tx;
+}
+
+static struct tls_sw_context_rx *init_ctx_rx(struct tls_context *ctx)
+{
+=09struct tls_sw_context_rx *sw_ctx_rx;
+
+=09if (!ctx->priv_ctx_rx) {
+=09=09sw_ctx_rx =3D kzalloc(sizeof(*sw_ctx_rx), GFP_KERNEL);
+=09=09if (!sw_ctx_rx)
+=09=09=09return NULL;
+=09} else {
+=09=09sw_ctx_rx =3D ctx->priv_ctx_rx;
+=09}
+
+=09crypto_init_wait(&sw_ctx_rx->async_wait);
+=09spin_lock_init(&sw_ctx_rx->decrypt_compl_lock);
+=09init_waitqueue_head(&sw_ctx_rx->wq);
+=09skb_queue_head_init(&sw_ctx_rx->rx_list);
+=09skb_queue_head_init(&sw_ctx_rx->async_hold);
+
+=09return sw_ctx_rx;
+}
+
 int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 {
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
@@ -2599,48 +2641,22 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09}
=20
 =09if (tx) {
-=09=09if (!ctx->priv_ctx_tx) {
-=09=09=09sw_ctx_tx =3D kzalloc(sizeof(*sw_ctx_tx), GFP_KERNEL);
-=09=09=09if (!sw_ctx_tx) {
-=09=09=09=09rc =3D -ENOMEM;
-=09=09=09=09goto out;
-=09=09=09}
-=09=09=09ctx->priv_ctx_tx =3D sw_ctx_tx;
-=09=09} else {
-=09=09=09sw_ctx_tx =3D
-=09=09=09=09(struct tls_sw_context_tx *)ctx->priv_ctx_tx;
-=09=09}
-=09} else {
-=09=09if (!ctx->priv_ctx_rx) {
-=09=09=09sw_ctx_rx =3D kzalloc(sizeof(*sw_ctx_rx), GFP_KERNEL);
-=09=09=09if (!sw_ctx_rx) {
-=09=09=09=09rc =3D -ENOMEM;
-=09=09=09=09goto out;
-=09=09=09}
-=09=09=09ctx->priv_ctx_rx =3D sw_ctx_rx;
-=09=09} else {
-=09=09=09sw_ctx_rx =3D
-=09=09=09=09(struct tls_sw_context_rx *)ctx->priv_ctx_rx;
-=09=09}
-=09}
+=09=09ctx->priv_ctx_tx =3D init_ctx_tx(ctx, sk);
+=09=09if (!ctx->priv_ctx_tx)
+=09=09=09return -ENOMEM;
=20
-=09if (tx) {
-=09=09crypto_init_wait(&sw_ctx_tx->async_wait);
-=09=09spin_lock_init(&sw_ctx_tx->encrypt_compl_lock);
+=09=09sw_ctx_tx =3D ctx->priv_ctx_tx;
 =09=09crypto_info =3D &ctx->crypto_send.info;
 =09=09cctx =3D &ctx->tx;
 =09=09aead =3D &sw_ctx_tx->aead_send;
-=09=09INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
-=09=09INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
-=09=09sw_ctx_tx->tx_work.sk =3D sk;
 =09} else {
-=09=09crypto_init_wait(&sw_ctx_rx->async_wait);
-=09=09spin_lock_init(&sw_ctx_rx->decrypt_compl_lock);
-=09=09init_waitqueue_head(&sw_ctx_rx->wq);
+=09=09ctx->priv_ctx_rx =3D init_ctx_rx(ctx);
+=09=09if (!ctx->priv_ctx_rx)
+=09=09=09return -ENOMEM;
+
+=09=09sw_ctx_rx =3D ctx->priv_ctx_rx;
 =09=09crypto_info =3D &ctx->crypto_recv.info;
 =09=09cctx =3D &ctx->rx;
-=09=09skb_queue_head_init(&sw_ctx_rx->rx_list);
-=09=09skb_queue_head_init(&sw_ctx_rx->async_hold);
 =09=09aead =3D &sw_ctx_rx->aead_recv;
 =09}
=20
--=20
2.42.0


