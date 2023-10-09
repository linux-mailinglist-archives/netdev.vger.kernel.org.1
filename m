Return-Path: <netdev+bounces-39316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9957BEBF7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9108B2819AD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2513FB03;
	Mon,  9 Oct 2023 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26183B2AA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:34 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513449E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:33 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-O7x1Zp3pP_G0bn1JRVvheQ-1; Mon, 09 Oct 2023 16:51:12 -0400
X-MC-Unique: O7x1Zp3pP_G0bn1JRVvheQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB51A3C025B2;
	Mon,  9 Oct 2023 20:51:11 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DABD036E1;
	Mon,  9 Oct 2023 20:51:10 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 11/14] tls: remove tls_context argument from tls_set_device_offload
Date: Mon,  9 Oct 2023 22:50:51 +0200
Message-ID: <5f5a8342eba0f0b07b12a7fe9a578576d833a270.1696596130.git.sd@queasysnail.net>
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

It's not really needed since we end up refetching it as tls_ctx. We
can also remove the NULL check, since we have already dereferenced ctx
in do_tls_setsockopt_conf.

While at it, fix up the reverse xmas tree ordering.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |  4 ++--
 net/tls/tls_device.c | 14 +++++++-------
 net/tls/tls_main.c   |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index d9e8cd73b20e..478b2c0060aa 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -227,7 +227,7 @@ static inline bool tls_strp_msg_mixed_decrypted(struct =
tls_sw_context_rx *ctx)
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
-int tls_set_device_offload(struct sock *sk, struct tls_context *ctx);
+int tls_set_device_offload(struct sock *sk);
 void tls_device_free_resources_tx(struct sock *sk);
 int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
 void tls_device_offload_cleanup_rx(struct sock *sk);
@@ -238,7 +238,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
=20
 static inline int
-tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
+tls_set_device_offload(struct sock *sk)
 {
 =09return -EOPNOTSUPP;
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 1dc217870f9d..fe52765beaee 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1057,21 +1057,21 @@ static struct tls_offload_context_tx *alloc_offload=
_ctx_tx(struct tls_context *c
 =09return offload_ctx;
 }
=20
-int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
+int tls_set_device_offload(struct sock *sk)
 {
-=09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
-=09struct tls_prot_info *prot =3D &tls_ctx->prot_info;
-=09const struct tls_cipher_desc *cipher_desc;
 =09struct tls_record_info *start_marker_record;
 =09struct tls_offload_context_tx *offload_ctx;
+=09const struct tls_cipher_desc *cipher_desc;
 =09struct tls_crypto_info *crypto_info;
+=09struct tls_prot_info *prot;
 =09struct net_device *netdev;
-=09char *iv, *rec_seq;
+=09struct tls_context *ctx;
 =09struct sk_buff *skb;
+=09char *iv, *rec_seq;
 =09int rc;
=20
-=09if (!ctx)
-=09=09return -EINVAL;
+=09ctx =3D tls_get_ctx(sk);
+=09prot =3D &ctx->prot_info;
=20
 =09if (ctx->priv_ctx_tx)
 =09=09return -EEXIST;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6c5e0cad89e8..a342853ab6ae 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -657,7 +657,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sock=
ptr_t optval,
 =09}
=20
 =09if (tx) {
-=09=09rc =3D tls_set_device_offload(sk, ctx);
+=09=09rc =3D tls_set_device_offload(sk);
 =09=09conf =3D TLS_HW;
 =09=09if (!rc) {
 =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
--=20
2.42.0


