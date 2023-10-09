Return-Path: <netdev+bounces-39315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640917BEBF6
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6375E1C20D7C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BE3FB33;
	Mon,  9 Oct 2023 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761903B789
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:28 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749EA3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:26 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-t7_Nv8bMM4mLrygnzwfgbg-1; Mon, 09 Oct 2023 16:51:16 -0400
X-MC-Unique: t7_Nv8bMM4mLrygnzwfgbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AEBA101A598;
	Mon,  9 Oct 2023 20:51:16 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 089EB36E1;
	Mon,  9 Oct 2023 20:51:14 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH net-next 14/14] tls: use fixed size for tls_offload_context_{tx,rx}.driver_state
Date: Mon,  9 Oct 2023 22:50:54 +0200
Message-ID: <728b735359789faa82676ea31d142840694a5aea.1696596130.git.sd@queasysnail.net>
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

driver_state is a flex array, but is always allocated by the tls core
to a fixed size (TLS_DRIVER_STATE_SIZE_{TX,RX}). Simplify the code by
making that size explicit so that sizeof(struct
tls_offload_context_{tx,rx}) works.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h    | 14 ++++----------
 net/tls/tls_device.c |  4 ++--
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 28cc40d7b945..962f0c501111 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -150,6 +150,7 @@ struct tls_record_info {
 =09skb_frag_t frags[MAX_SKB_FRAGS];
 };
=20
+#define TLS_DRIVER_STATE_SIZE_TX=0916
 struct tls_offload_context_tx {
 =09struct crypto_aead *aead_send;
 =09spinlock_t lock;=09/* protects records list */
@@ -163,17 +164,13 @@ struct tls_offload_context_tx {
 =09void (*sk_destruct)(struct sock *sk);
 =09struct work_struct destruct_work;
 =09struct tls_context *ctx;
-=09u8 driver_state[] __aligned(8);
 =09/* The TLS layer reserves room for driver specific state
 =09 * Currently the belief is that there is not enough
 =09 * driver specific state to justify another layer of indirection
 =09 */
-#define TLS_DRIVER_STATE_SIZE_TX=0916
+=09u8 driver_state[TLS_DRIVER_STATE_SIZE_TX] __aligned(8);
 };
=20
-#define TLS_OFFLOAD_CONTEXT_SIZE_TX                                       =
     \
-=09(sizeof(struct tls_offload_context_tx) + TLS_DRIVER_STATE_SIZE_TX)
-
 enum tls_context_flags {
 =09/* tls_device_down was called after the netdev went down, device state
 =09 * was released, and kTLS works in software, even though rx_conf is
@@ -303,6 +300,7 @@ struct tls_offload_resync_async {
 =09u32 log[TLS_DEVICE_RESYNC_ASYNC_LOGMAX];
 };
=20
+#define TLS_DRIVER_STATE_SIZE_RX=098
 struct tls_offload_context_rx {
 =09/* sw must be the first member of tls_offload_context_rx */
 =09struct tls_sw_context_rx sw;
@@ -326,17 +324,13 @@ struct tls_offload_context_rx {
 =09=09=09struct tls_offload_resync_async *resync_async;
 =09=09};
 =09};
-=09u8 driver_state[] __aligned(8);
 =09/* The TLS layer reserves room for driver specific state
 =09 * Currently the belief is that there is not enough
 =09 * driver specific state to justify another layer of indirection
 =09 */
-#define TLS_DRIVER_STATE_SIZE_RX=098
+=09u8 driver_state[TLS_DRIVER_STATE_SIZE_RX] __aligned(8);
 };
=20
-#define TLS_OFFLOAD_CONTEXT_SIZE_RX=09=09=09=09=09\
-=09(sizeof(struct tls_offload_context_rx) + TLS_DRIVER_STATE_SIZE_RX)
-
 struct tls_record_info *tls_get_record(struct tls_offload_context_tx *cont=
ext,
 =09=09=09=09       u32 seq, u64 *p_record_sn);
=20
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index fe52765beaee..f01543557a60 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1038,7 +1038,7 @@ static struct tls_offload_context_tx *alloc_offload_c=
tx_tx(struct tls_context *c
 =09struct tls_offload_context_tx *offload_ctx;
 =09__be64 rcd_sn;
=20
-=09offload_ctx =3D kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);
+=09offload_ctx =3D kzalloc(sizeof(*offload_ctx), GFP_KERNEL);
 =09if (!offload_ctx)
 =09=09return NULL;
=20
@@ -1225,7 +1225,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct=
 tls_context *ctx)
 =09=09goto release_lock;
 =09}
=20
-=09context =3D kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_RX, GFP_KERNEL);
+=09context =3D kzalloc(sizeof(*context), GFP_KERNEL);
 =09if (!context) {
 =09=09rc =3D -ENOMEM;
 =09=09goto release_lock;
--=20
2.42.0


