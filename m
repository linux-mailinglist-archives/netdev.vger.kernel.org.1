Return-Path: <netdev+bounces-39318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A387BEBF9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09688282142
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633F41211;
	Mon,  9 Oct 2023 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD653C6A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:37 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D192
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:33 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-3PvcsaBCMUqiGubCdAmDHA-1; Mon, 09 Oct 2023 16:51:15 -0400
X-MC-Unique: 3PvcsaBCMUqiGubCdAmDHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA5F78039C1;
	Mon,  9 Oct 2023 20:51:14 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EEB536E1;
	Mon,  9 Oct 2023 20:51:13 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH net-next 13/14] chcr_ktls: use tls_offload_context_tx and driver_state like other drivers
Date: Mon,  9 Oct 2023 22:50:53 +0200
Message-ID: <e238d12c1a55cdd9d72ec0dfb4e7153c3551c4ee.1696596130.git.sd@queasysnail.net>
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

chcr_ktls uses the space reserved in driver_state by
tls_set_device_offload, but makes up into own wrapper around
tls_offload_context_tx instead of accessing driver_state via the
__tls_driver_ctx helper.

In this driver, driver_state is only used to store a pointer to a
larger context struct allocated by the driver.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 43 ++++++++-----------
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.h | 36 ++++++++++++----
 2 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c=
 b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index bcdc7fc2f427..6482728794dd 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -361,9 +361,7 @@ static void chcr_ktls_dev_del(struct net_device *netdev=
,
 =09=09=09      struct tls_context *tls_ctx,
 =09=09=09      enum tls_offload_ctx_dir direction)
 {
-=09struct chcr_ktls_ofld_ctx_tx *tx_ctx =3D
-=09=09=09=09chcr_get_ktls_tx_context(tls_ctx);
-=09struct chcr_ktls_info *tx_info =3D tx_ctx->chcr_info;
+=09struct chcr_ktls_info *tx_info =3D chcr_get_ktls_tx_info(tls_ctx);
 =09struct ch_ktls_port_stats_debug *port_stats;
 =09struct chcr_ktls_uld_ctx *u_ctx;
=20
@@ -396,7 +394,7 @@ static void chcr_ktls_dev_del(struct net_device *netdev=
,
 =09port_stats =3D &tx_info->adap->ch_ktls_stats.ktls_port[tx_info->port_id=
];
 =09atomic64_inc(&port_stats->ktls_tx_connection_close);
 =09kvfree(tx_info);
-=09tx_ctx->chcr_info =3D NULL;
+=09chcr_set_ktls_tx_info(tls_ctx, NULL);
 =09/* release module refcount */
 =09module_put(THIS_MODULE);
 }
@@ -417,7 +415,6 @@ static int chcr_ktls_dev_add(struct net_device *netdev,=
 struct sock *sk,
 {
 =09struct tls_context *tls_ctx =3D tls_get_ctx(sk);
 =09struct ch_ktls_port_stats_debug *port_stats;
-=09struct chcr_ktls_ofld_ctx_tx *tx_ctx;
 =09struct chcr_ktls_uld_ctx *u_ctx;
 =09struct chcr_ktls_info *tx_info;
 =09struct dst_entry *dst;
@@ -427,8 +424,6 @@ static int chcr_ktls_dev_add(struct net_device *netdev,=
 struct sock *sk,
 =09u8 daaddr[16];
 =09int ret =3D -1;
=20
-=09tx_ctx =3D chcr_get_ktls_tx_context(tls_ctx);
-
 =09pi =3D netdev_priv(netdev);
 =09adap =3D pi->adapter;
 =09port_stats =3D &adap->ch_ktls_stats.ktls_port[pi->port_id];
@@ -440,7 +435,7 @@ static int chcr_ktls_dev_add(struct net_device *netdev,=
 struct sock *sk,
 =09=09goto out;
 =09}
=20
-=09if (tx_ctx->chcr_info)
+=09if (chcr_get_ktls_tx_info(tls_ctx))
 =09=09goto out;
=20
 =09if (u_ctx && u_ctx->detach)
@@ -566,7 +561,7 @@ static int chcr_ktls_dev_add(struct net_device *netdev,=
 struct sock *sk,
 =09=09goto free_tid;
=20
 =09atomic64_inc(&port_stats->ktls_tx_ctx);
-=09tx_ctx->chcr_info =3D tx_info;
+=09chcr_set_ktls_tx_info(tls_ctx, tx_info);
=20
 =09return 0;
=20
@@ -647,7 +642,7 @@ static int chcr_ktls_cpl_act_open_rpl(struct adapter *a=
dap,
 {
 =09const struct cpl_act_open_rpl *p =3D (void *)input;
 =09struct chcr_ktls_info *tx_info =3D NULL;
-=09struct chcr_ktls_ofld_ctx_tx *tx_ctx;
+=09struct tls_offload_context_tx *tx_ctx;
 =09struct chcr_ktls_uld_ctx *u_ctx;
 =09unsigned int atid, tid, status;
 =09struct tls_context *tls_ctx;
@@ -686,7 +681,7 @@ static int chcr_ktls_cpl_act_open_rpl(struct adapter *a=
dap,
 =09=09cxgb4_insert_tid(t, tx_info, tx_info->tid, tx_info->ip_family);
 =09=09/* Adding tid */
 =09=09tls_ctx =3D tls_get_ctx(tx_info->sk);
-=09=09tx_ctx =3D chcr_get_ktls_tx_context(tls_ctx);
+=09=09tx_ctx =3D tls_offload_ctx_tx(tls_ctx);
 =09=09u_ctx =3D adap->uld[CXGB4_ULD_KTLS].handle;
 =09=09if (u_ctx) {
 =09=09=09ret =3D xa_insert_bh(&u_ctx->tid_list, tid, tx_ctx,
@@ -1924,7 +1919,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
 {
 =09u32 tls_end_offset, tcp_seq, skb_data_len, skb_offset;
 =09struct ch_ktls_port_stats_debug *port_stats;
-=09struct chcr_ktls_ofld_ctx_tx *tx_ctx;
+=09struct tls_offload_context_tx *tx_ctx;
 =09struct ch_ktls_stats_debug *stats;
 =09struct tcphdr *th =3D tcp_hdr(skb);
 =09int data_len, qidx, ret =3D 0, mss;
@@ -1944,6 +1939,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
 =09mss =3D skb_is_gso(skb) ? skb_shinfo(skb)->gso_size : data_len;
=20
 =09tls_ctx =3D tls_get_ctx(skb->sk);
+=09tx_ctx =3D tls_offload_ctx_tx(tls_ctx);
 =09tls_netdev =3D rcu_dereference_bh(tls_ctx->netdev);
 =09/* Don't quit on NULL: if tls_device_down is running in parallel,
 =09 * netdev might become NULL, even if tls_is_skb_tx_device_offloaded was
@@ -1952,8 +1948,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
 =09if (unlikely(tls_netdev && tls_netdev !=3D dev))
 =09=09goto out;
=20
-=09tx_ctx =3D chcr_get_ktls_tx_context(tls_ctx);
-=09tx_info =3D tx_ctx->chcr_info;
+=09tx_info =3D chcr_get_ktls_tx_info(tls_ctx);
=20
 =09if (unlikely(!tx_info))
 =09=09goto out;
@@ -1979,19 +1974,19 @@ static int chcr_ktls_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 =09 * we will send the complete record again.
 =09 */
=20
-=09spin_lock_irqsave(&tx_ctx->base.lock, flags);
+=09spin_lock_irqsave(&tx_ctx->lock, flags);
=20
 =09do {
=20
 =09=09cxgb4_reclaim_completed_tx(adap, &q->q, true);
 =09=09/* fetch the tls record */
-=09=09record =3D tls_get_record(&tx_ctx->base, tcp_seq,
+=09=09record =3D tls_get_record(tx_ctx, tcp_seq,
 =09=09=09=09=09&tx_info->record_no);
 =09=09/* By the time packet reached to us, ACK is received, and record
 =09=09 * won't be found in that case, handle it gracefully.
 =09=09 */
 =09=09if (unlikely(!record)) {
-=09=09=09spin_unlock_irqrestore(&tx_ctx->base.lock, flags);
+=09=09=09spin_unlock_irqrestore(&tx_ctx->lock, flags);
 =09=09=09atomic64_inc(&port_stats->ktls_tx_drop_no_sync_data);
 =09=09=09goto out;
 =09=09}
@@ -2015,7 +2010,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
 =09=09=09=09=09=09      tls_end_offset !=3D
 =09=09=09=09=09=09      record->len);
 =09=09=09if (ret) {
-=09=09=09=09spin_unlock_irqrestore(&tx_ctx->base.lock,
+=09=09=09=09spin_unlock_irqrestore(&tx_ctx->lock,
 =09=09=09=09=09=09       flags);
 =09=09=09=09goto out;
 =09=09=09}
@@ -2046,7 +2041,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
 =09=09=09=09/* free the refcount taken earlier */
 =09=09=09=09if (tls_end_offset < data_len)
 =09=09=09=09=09dev_kfree_skb_any(skb);
-=09=09=09=09spin_unlock_irqrestore(&tx_ctx->base.lock, flags);
+=09=09=09=09spin_unlock_irqrestore(&tx_ctx->lock, flags);
 =09=09=09=09goto out;
 =09=09=09}
=20
@@ -2082,7 +2077,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
=20
 =09=09/* if any failure, come out from the loop. */
 =09=09if (ret) {
-=09=09=09spin_unlock_irqrestore(&tx_ctx->base.lock, flags);
+=09=09=09spin_unlock_irqrestore(&tx_ctx->lock, flags);
 =09=09=09if (th->fin)
 =09=09=09=09dev_kfree_skb_any(skb);
=20
@@ -2097,7 +2092,7 @@ static int chcr_ktls_xmit(struct sk_buff *skb, struct=
 net_device *dev)
=20
 =09} while (data_len > 0);
=20
-=09spin_unlock_irqrestore(&tx_ctx->base.lock, flags);
+=09spin_unlock_irqrestore(&tx_ctx->lock, flags);
 =09atomic64_inc(&port_stats->ktls_tx_encrypted_packets);
 =09atomic64_add(skb_data_len, &port_stats->ktls_tx_encrypted_bytes);
=20
@@ -2185,17 +2180,17 @@ static void clear_conn_resources(struct chcr_ktls_i=
nfo *tx_info)
 static void ch_ktls_reset_all_conn(struct chcr_ktls_uld_ctx *u_ctx)
 {
 =09struct ch_ktls_port_stats_debug *port_stats;
-=09struct chcr_ktls_ofld_ctx_tx *tx_ctx;
+=09struct tls_offload_context_tx *tx_ctx;
 =09struct chcr_ktls_info *tx_info;
 =09unsigned long index;
=20
 =09xa_for_each(&u_ctx->tid_list, index, tx_ctx) {
-=09=09tx_info =3D tx_ctx->chcr_info;
+=09=09tx_info =3D __chcr_get_ktls_tx_info(tx_ctx);
 =09=09clear_conn_resources(tx_info);
 =09=09port_stats =3D &tx_info->adap->ch_ktls_stats.ktls_port[tx_info->port=
_id];
 =09=09atomic64_inc(&port_stats->ktls_tx_connection_close);
 =09=09kvfree(tx_info);
-=09=09tx_ctx->chcr_info =3D NULL;
+=09=09memset(tx_ctx->driver_state, 0, TLS_DRIVER_STATE_SIZE_TX);
 =09=09/* release module refcount */
 =09=09module_put(THIS_MODULE);
 =09}
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h=
 b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
index 10572dc55365..dbbba92bf540 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
@@ -67,8 +67,7 @@ struct chcr_ktls_info {
 =09bool pending_close;
 };
=20
-struct chcr_ktls_ofld_ctx_tx {
-=09struct tls_offload_context_tx base;
+struct chcr_ktls_ctx_tx {
 =09struct chcr_ktls_info *chcr_info;
 };
=20
@@ -79,14 +78,33 @@ struct chcr_ktls_uld_ctx {
 =09bool detach;
 };
=20
-static inline struct chcr_ktls_ofld_ctx_tx *
-chcr_get_ktls_tx_context(struct tls_context *tls_ctx)
+static inline struct chcr_ktls_info *
+__chcr_get_ktls_tx_info(struct tls_offload_context_tx *octx)
 {
-=09BUILD_BUG_ON(sizeof(struct chcr_ktls_ofld_ctx_tx) >
-=09=09     TLS_OFFLOAD_CONTEXT_SIZE_TX);
-=09return container_of(tls_offload_ctx_tx(tls_ctx),
-=09=09=09    struct chcr_ktls_ofld_ctx_tx,
-=09=09=09    base);
+=09struct chcr_ktls_ctx_tx *priv_ctx;
+
+=09BUILD_BUG_ON(sizeof(struct chcr_ktls_ctx_tx) > TLS_DRIVER_STATE_SIZE_TX=
);
+=09priv_ctx =3D (struct chcr_ktls_ctx_tx *)octx->driver_state;
+=09return priv_ctx->chcr_info;
+}
+
+static inline struct chcr_ktls_info *
+chcr_get_ktls_tx_info(struct tls_context *tls_ctx)
+{
+=09struct chcr_ktls_ctx_tx *priv_ctx;
+
+=09BUILD_BUG_ON(sizeof(struct chcr_ktls_ctx_tx) > TLS_DRIVER_STATE_SIZE_TX=
);
+=09priv_ctx =3D (struct chcr_ktls_ctx_tx *)__tls_driver_ctx(tls_ctx, TLS_O=
FFLOAD_CTX_DIR_TX);
+=09return priv_ctx->chcr_info;
+}
+
+static inline void
+chcr_set_ktls_tx_info(struct tls_context *tls_ctx, struct chcr_ktls_info *=
chcr_info)
+{
+=09struct chcr_ktls_ctx_tx *priv_ctx;
+
+=09priv_ctx =3D __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+=09priv_ctx->chcr_info =3D chcr_info;
 }
=20
 static inline int chcr_get_first_rx_qid(struct adapter *adap)
--=20
2.42.0


