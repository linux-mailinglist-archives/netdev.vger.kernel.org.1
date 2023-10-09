Return-Path: <netdev+bounces-39314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DF17BEBF5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9C1C20CF1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604573C6A6;
	Mon,  9 Oct 2023 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDB1F5E4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:27 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF39E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:25 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-Vvd8oqyVOaq5b0AH4VHkhw-1; Mon, 09 Oct 2023 16:51:09 -0400
X-MC-Unique: Vvd8oqyVOaq5b0AH4VHkhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53B693806735;
	Mon,  9 Oct 2023 20:51:09 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52F8336E1;
	Mon,  9 Oct 2023 20:51:08 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 09/14] tls: add a helper to allocate/initialize offload_ctx_tx
Date: Mon,  9 Oct 2023 22:50:49 +0200
Message-ID: <a8b0d7431e6f74eaba081b5598f1ece2b2336dd5.1696596130.git.sd@queasysnail.net>
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
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simplify tls_set_device_offload a bit.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_device.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 3d73dd97e903..0184426251b0 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1033,6 +1033,30 @@ static void tls_device_attach(struct tls_context *ct=
x, struct sock *sk,
 =09}
 }
=20
+static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_cont=
ext *ctx)
+{
+=09struct tls_offload_context_tx *offload_ctx;
+=09__be64 rcd_sn;
+
+=09offload_ctx =3D kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);
+=09if (!offload_ctx)
+=09=09return NULL;
+
+=09INIT_WORK(&offload_ctx->destruct_work, tls_device_tx_del_task);
+=09INIT_LIST_HEAD(&offload_ctx->records_list);
+=09spin_lock_init(&offload_ctx->lock);
+=09sg_init_table(offload_ctx->sg_tx_data,
+=09=09      ARRAY_SIZE(offload_ctx->sg_tx_data));
+
+=09/* start at rec_seq - 1 to account for the start marker record */
+=09memcpy(&rcd_sn, ctx->tx.rec_seq, sizeof(rcd_sn));
+=09offload_ctx->unacked_record_sn =3D be64_to_cpu(rcd_sn) - 1;
+
+=09offload_ctx->ctx =3D ctx;
+
+=09return offload_ctx;
+}
+
 int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 {
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
@@ -1044,7 +1068,6 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 =09struct net_device *netdev;
 =09char *iv, *rec_seq;
 =09struct sk_buff *skb;
-=09__be64 rcd_sn;
 =09int rc;
=20
 =09if (!ctx)
@@ -1092,7 +1115,7 @@ int tls_set_device_offload(struct sock *sk, struct tl=
s_context *ctx)
 =09=09goto release_netdev;
 =09}
=20
-=09offload_ctx =3D kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);
+=09offload_ctx =3D alloc_offload_ctx_tx(ctx);
 =09if (!offload_ctx) {
 =09=09rc =3D -ENOMEM;
 =09=09goto free_marker_record;
@@ -1102,22 +1125,10 @@ int tls_set_device_offload(struct sock *sk, struct =
tls_context *ctx)
 =09if (rc)
 =09=09goto free_offload_ctx;
=20
-=09/* start at rec_seq - 1 to account for the start marker record */
-=09memcpy(&rcd_sn, ctx->tx.rec_seq, sizeof(rcd_sn));
-=09offload_ctx->unacked_record_sn =3D be64_to_cpu(rcd_sn) - 1;
-
 =09start_marker_record->end_seq =3D tcp_sk(sk)->write_seq;
 =09start_marker_record->len =3D 0;
 =09start_marker_record->num_frags =3D 0;
-
-=09INIT_WORK(&offload_ctx->destruct_work, tls_device_tx_del_task);
-=09offload_ctx->ctx =3D ctx;
-
-=09INIT_LIST_HEAD(&offload_ctx->records_list);
 =09list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
-=09spin_lock_init(&offload_ctx->lock);
-=09sg_init_table(offload_ctx->sg_tx_data,
-=09=09      ARRAY_SIZE(offload_ctx->sg_tx_data));
=20
 =09clean_acked_data_enable(inet_csk(sk), &tls_icsk_clean_acked);
 =09ctx->push_pending_record =3D tls_device_push_pending_record;
--=20
2.42.0


