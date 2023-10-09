Return-Path: <netdev+bounces-39307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C27BEBED
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3438D281CD7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4693FB2B;
	Mon,  9 Oct 2023 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEE200BA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:07 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313EFA6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:06 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-mf7ez0oDPf6--j5leW5hHw-1; Mon, 09 Oct 2023 16:51:02 -0400
X-MC-Unique: mf7ez0oDPf6--j5leW5hHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A318A800883;
	Mon,  9 Oct 2023 20:51:01 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A263236E1;
	Mon,  9 Oct 2023 20:51:00 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 03/14] tls: store rec_seq directly within cipher_context
Date: Mon,  9 Oct 2023 22:50:43 +0200
Message-ID: <9ce5bdc627c46597cccc4ff638cc726a6de9c52e.1696596130.git.sd@queasysnail.net>
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

TLS_MAX_REC_SEQ_SIZE is 8B, we don't get anything by using kmalloc.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h    |  2 +-
 net/tls/tls_device.c | 11 ++---------
 net/tls/tls_main.c   |  1 -
 net/tls/tls_sw.c     | 13 ++-----------
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index a2b44578dcb7..f3f22b08af26 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -194,7 +194,7 @@ enum tls_context_flags {
=20
 struct cipher_context {
 =09char *iv;
-=09char *rec_seq;
+=09char rec_seq[TLS_MAX_REC_SEQ_SIZE];
 };
=20
 union tls_crypto_context {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index fbd687a0c66f..525d7b813869 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -58,7 +58,6 @@ static void tls_device_free_ctx(struct tls_context *ctx)
 {
 =09if (ctx->tx_conf =3D=3D TLS_HW) {
 =09=09kfree(tls_offload_ctx_tx(ctx));
-=09=09kfree(ctx->tx.rec_seq);
 =09=09kfree(ctx->tx.iv);
 =09}
=20
@@ -1098,16 +1097,12 @@ int tls_set_device_offload(struct sock *sk, struct =
tls_context *ctx)
 =09memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
=20
 =09prot->rec_seq_size =3D cipher_desc->rec_seq;
-=09ctx->tx.rec_seq =3D kmemdup(rec_seq, cipher_desc->rec_seq, GFP_KERNEL);
-=09if (!ctx->tx.rec_seq) {
-=09=09rc =3D -ENOMEM;
-=09=09goto free_iv;
-=09}
+=09memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
=20
 =09start_marker_record =3D kmalloc(sizeof(*start_marker_record), GFP_KERNE=
L);
 =09if (!start_marker_record) {
 =09=09rc =3D -ENOMEM;
-=09=09goto free_rec_seq;
+=09=09goto free_iv;
 =09}
=20
 =09offload_ctx =3D kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);
@@ -1192,8 +1187,6 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 =09ctx->priv_ctx_tx =3D NULL;
 free_marker_record:
 =09kfree(start_marker_record);
-free_rec_seq:
-=09kfree(ctx->tx.rec_seq);
 free_iv:
 =09kfree(ctx->tx.iv);
 release_netdev:
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 02f583ff9239..f705d812fc36 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -344,7 +344,6 @@ static void tls_sk_proto_cleanup(struct sock *sk,
=20
 =09/* We need these for tls_sw_fallback handling of other packets */
 =09if (ctx->tx_conf =3D=3D TLS_SW) {
-=09=09kfree(ctx->tx.rec_seq);
 =09=09kfree(ctx->tx.iv);
 =09=09tls_sw_release_resources_tx(sk);
 =09=09TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 270712b8d391..93d40c9a6823 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2467,7 +2467,6 @@ void tls_sw_release_resources_rx(struct sock *sk)
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
 =09struct tls_sw_context_rx *ctx =3D tls_sw_ctx_rx(tls_ctx);
=20
-=09kfree(tls_ctx->rx.rec_seq);
 =09kfree(tls_ctx->rx.iv);
=20
 =09if (ctx->aead_recv) {
@@ -2692,19 +2691,14 @@ int tls_set_sw_offload(struct sock *sk, struct tls_=
context *ctx, int tx)
 =09prot->rec_seq_size =3D cipher_desc->rec_seq;
 =09memcpy(cctx->iv, salt, cipher_desc->salt);
 =09memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
-
-=09cctx->rec_seq =3D kmemdup(rec_seq, cipher_desc->rec_seq, GFP_KERNEL);
-=09if (!cctx->rec_seq) {
-=09=09rc =3D -ENOMEM;
-=09=09goto free_iv;
-=09}
+=09memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
=20
 =09if (!*aead) {
 =09=09*aead =3D crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
 =09=09if (IS_ERR(*aead)) {
 =09=09=09rc =3D PTR_ERR(*aead);
 =09=09=09*aead =3D NULL;
-=09=09=09goto free_rec_seq;
+=09=09=09goto free_iv;
 =09=09}
 =09}
=20
@@ -2736,9 +2730,6 @@ int tls_set_sw_offload(struct sock *sk, struct tls_co=
ntext *ctx, int tx)
 free_aead:
 =09crypto_free_aead(*aead);
 =09*aead =3D NULL;
-free_rec_seq:
-=09kfree(cctx->rec_seq);
-=09cctx->rec_seq =3D NULL;
 free_iv:
 =09kfree(cctx->iv);
 =09cctx->iv =3D NULL;
--=20
2.42.0


