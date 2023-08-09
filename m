Return-Path: <netdev+bounces-25852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0409776012
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A47F281C62
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290318B0B;
	Wed,  9 Aug 2023 12:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4818B09
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:59:44 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F241FF9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:59:43 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-UjERp_4sMz6znNLlqYM6Rw-1; Wed, 09 Aug 2023 08:59:25 -0400
X-MC-Unique: UjERp_4sMz6znNLlqYM6Rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC8AC3C11A02;
	Wed,  9 Aug 2023 12:59:24 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B7032166B25;
	Wed,  9 Aug 2023 12:59:22 +0000 (UTC)
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
Subject: [PATCH net-next v3 2/6] tls: block decryption when a rekey is pending
Date: Wed,  9 Aug 2023 14:58:51 +0200
Message-Id: <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
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

When a TLS handshake record carrying a KeyUpdate message is received,
all subsequent records will be encrypted with a new key. We need to
stop decrypting incoming records with the old key, and wait until
userspace provides a new key.

Make a note of this in the RX context just after decrypting that
record, and stop recvmsg/splice calls with EKEYEXPIRED until the new
key is available.

v3:
 - move key_update_pending check into tls_rx_rec_wait (Jakub)
 - TLS_RECORD_TYPE_HANDSHAKE was added to include/net/tls_prot.h by
   the tls handshake series, drop that from this patch
 - move key_update_pending into an existing hole

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h |  3 +++
 net/tls/tls_sw.c  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 06fca9160346..219a4f38c0e4 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -69,6 +69,8 @@ extern const struct tls_cipher_size_desc tls_cipher_size_=
desc[];
=20
 #define TLS_CRYPTO_INFO_READY(info)=09((info)->cipher_type)
=20
+#define TLS_HANDSHAKE_KEYUPDATE=09=0924=09/* rfc8446 B.3: Key update */
+
 #define TLS_AAD_SPACE_SIZE=09=0913
=20
 #define MAX_IV_SIZE=09=09=0916
@@ -141,6 +143,7 @@ struct tls_sw_context_rx {
 =09u8 async_capable:1;
 =09u8 zc_capable:1;
 =09u8 reader_contended:1;
+=09bool key_update_pending;
=20
 =09struct tls_strparser strp;
=20
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2ca0eb90a2a5..497f56c5f169 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1293,6 +1293,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *ps=
ock, bool nonblock,
 =09DEFINE_WAIT_FUNC(wait, woken_wake_function);
 =09long timeo;
=20
+=09/* a rekey is pending, let userspace deal with it */
+=09if (unlikely(ctx->key_update_pending))
+=09=09return -EKEYEXPIRED;
+
 =09timeo =3D sock_rcvtimeo(sk, nonblock);
=20
 =09while (!tls_strp_msg_ready(ctx)) {
@@ -1689,6 +1693,33 @@ tls_decrypt_device(struct sock *sk, struct msghdr *m=
sg,
 =09return 1;
 }
=20
+static int tls_check_pending_rekey(struct sock *sk, struct sk_buff *skb)
+{
+=09const struct tls_msg *tlm =3D tls_msg(skb);
+=09const struct strp_msg *rxm =3D strp_msg(skb);
+
+=09if (tlm->control =3D=3D TLS_RECORD_TYPE_HANDSHAKE) {
+=09=09char hs_type;
+=09=09int err;
+
+=09=09if (rxm->full_len < 1)
+=09=09=09return -EINVAL;
+
+=09=09err =3D skb_copy_bits(skb, rxm->offset, &hs_type, 1);
+=09=09if (err < 0)
+=09=09=09return err;
+
+=09=09if (hs_type =3D=3D TLS_HANDSHAKE_KEYUPDATE) {
+=09=09=09struct tls_context *ctx =3D tls_get_ctx(sk);
+=09=09=09struct tls_sw_context_rx *rx_ctx =3D ctx->priv_ctx_rx;
+
+=09=09=09rx_ctx->key_update_pending =3D true;
+=09=09}
+=09}
+
+=09return 0;
+}
+
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 =09=09=09     struct tls_decrypt_arg *darg)
 {
@@ -1708,6 +1739,10 @@ static int tls_rx_one_record(struct sock *sk, struct=
 msghdr *msg,
 =09rxm->full_len -=3D prot->overhead_size;
 =09tls_advance_record_sn(sk, prot, &tls_ctx->rx);
=20
+=09err =3D tls_check_pending_rekey(sk, darg->skb);
+=09if (err < 0)
+=09=09return err;
+
 =09return 0;
 }
=20
@@ -2642,6 +2677,7 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09=09skb_queue_head_init(&sw_ctx_rx->rx_list);
 =09=09skb_queue_head_init(&sw_ctx_rx->async_hold);
 =09=09aead =3D &sw_ctx_rx->aead_recv;
+=09=09sw_ctx_rx->key_update_pending =3D false;
 =09}
=20
 =09switch (crypto_info->cipher_type) {
--=20
2.40.1


