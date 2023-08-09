Return-Path: <netdev+bounces-25851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61179776011
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F6C1C21221
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6118AF4;
	Wed,  9 Aug 2023 12:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA98BE0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:59:44 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC41FF5
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:59:43 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-4zjUEokNM8OHUhZVgKvMLQ-1; Wed, 09 Aug 2023 08:59:23 -0400
X-MC-Unique: 4zjUEokNM8OHUhZVgKvMLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2EC838008B3;
	Wed,  9 Aug 2023 12:59:22 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 010482166B25;
	Wed,  9 Aug 2023 12:59:20 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/6] tls: remove tls_context argument from tls_set_sw_offload
Date: Wed,  9 Aug 2023 14:58:50 +0200
Message-Id: <49bb1e97ace3d18c7b57b2ae6a5011643d351f0a.1691584074.git.sd@queasysnail.net>
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

It's not really needed since we end up refetching it as tls_ctx. We
can also remove the NULL check, since we have already dereferenced ctx
in do_tls_setsockopt_conf.

v2: reverse xmas tree

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |  2 +-
 net/tls/tls_device.c |  2 +-
 net/tls/tls_main.c   |  4 ++--
 net/tls/tls_sw.c     | 17 +++++++----------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 164d6a955e26..6916ff4fbde6 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -89,7 +89,7 @@ void update_sk_prot(struct sock *sk, struct tls_context *=
ctx);
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
=20
-int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx);
+int tls_set_sw_offload(struct sock *sk, int tx);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 5df18f696d7f..cc1918a279d4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1275,7 +1275,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct=
 tls_context *ctx)
 =09context->resync_nh_reset =3D 1;
=20
 =09ctx->priv_ctx_rx =3D context;
-=09rc =3D tls_set_sw_offload(sk, ctx, 0);
+=09rc =3D tls_set_sw_offload(sk, 0);
 =09if (rc)
 =09=09goto release_ctx;
=20
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7dbb8cd8f809..ffc50454758e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -799,7 +799,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 =09=09} else {
-=09=09=09rc =3D tls_set_sw_offload(sk, ctx, 1);
+=09=09=09rc =3D tls_set_sw_offload(sk, 1);
 =09=09=09if (rc)
 =09=09=09=09goto err_crypto_info;
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
@@ -813,7 +813,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
 =09=09} else {
-=09=09=09rc =3D tls_set_sw_offload(sk, ctx, 0);
+=09=09=09rc =3D tls_set_sw_offload(sk, 0);
 =09=09=09if (rc)
 =09=09=09=09goto err_crypto_info;
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5c122d7bb784..2ca0eb90a2a5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2581,25 +2581,22 @@ void tls_update_rx_zc_capable(struct tls_context *t=
ls_ctx)
 =09=09tls_ctx->prot_info.version !=3D TLS_1_3_VERSION;
 }
=20
-int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
+int tls_set_sw_offload(struct sock *sk, int tx)
 {
-=09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
-=09struct tls_prot_info *prot =3D &tls_ctx->prot_info;
-=09struct tls_crypto_info *crypto_info;
+=09u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
+=09char *iv, *rec_seq, *key, *salt, *cipher_name;
 =09struct tls_sw_context_tx *sw_ctx_tx =3D NULL;
 =09struct tls_sw_context_rx *sw_ctx_rx =3D NULL;
+=09struct tls_context *ctx =3D tls_get_ctx(sk);
+=09struct tls_crypto_info *crypto_info;
 =09struct cipher_context *cctx;
+=09struct tls_prot_info *prot;
 =09struct crypto_aead **aead;
-=09u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
 =09struct crypto_tfm *tfm;
-=09char *iv, *rec_seq, *key, *salt, *cipher_name;
 =09size_t keysize;
 =09int rc =3D 0;
=20
-=09if (!ctx) {
-=09=09rc =3D -EINVAL;
-=09=09goto out;
-=09}
+=09prot =3D &ctx->prot_info;
=20
 =09if (tx) {
 =09=09if (!ctx->priv_ctx_tx) {
--=20
2.40.1


