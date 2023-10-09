Return-Path: <netdev+bounces-39306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067F7BEBEC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CF11C20B2B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9623B789;
	Mon,  9 Oct 2023 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD51F19D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:06 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5C92
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:05 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-Ol3A61iJMJKKjCF7oVTcYw-1; Mon, 09 Oct 2023 16:51:01 -0400
X-MC-Unique: Ol3A61iJMJKKjCF7oVTcYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FD358007A4;
	Mon,  9 Oct 2023 20:51:00 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6026236E1;
	Mon,  9 Oct 2023 20:50:59 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 02/14] tls: drop unnecessary cipher_type checks in tls offload
Date: Mon,  9 Oct 2023 22:50:42 +0200
Message-ID: <91d001ffe0f6e1e2777edebdf82a0704cffd6cc0.1696596130.git.sd@queasysnail.net>
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

We should never reach tls_device_reencrypt, tls_enc_record, or
tls_enc_skb with a cipher_type that can't be offloaded. Replace those
checks with a DEBUG_NET_WARN_ON_ONCE, and use cipher_desc instead of
hard-coding offloadable cipher types.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_device.c          |  8 +-------
 net/tls/tls_device_fallback.c | 17 +++--------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 8c94c926606a..fbd687a0c66f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -891,14 +891,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_conte=
xt *tls_ctx)
 =09struct strp_msg *rxm;
 =09char *orig_buf, *buf;
=20
-=09switch (tls_ctx->crypto_recv.info.cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128:
-=09case TLS_CIPHER_AES_GCM_256:
-=09=09break;
-=09default:
-=09=09return -EINVAL;
-=09}
 =09cipher_desc =3D get_cipher_desc(tls_ctx->crypto_recv.info.cipher_type);
+=09DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
=20
 =09rxm =3D strp_msg(tls_strp_msg(sw_ctx));
 =09orig_buf =3D kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index b4a65f53d9c0..1d2b4d83ccab 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -62,14 +62,8 @@ static int tls_enc_record(struct aead_request *aead_req,
 =09u16 len;
 =09int rc;
=20
-=09switch (prot->cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128:
-=09case TLS_CIPHER_AES_GCM_256:
-=09=09break;
-=09default:
-=09=09return -EINVAL;
-=09}
 =09cipher_desc =3D get_cipher_desc(prot->cipher_type);
+=09DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
=20
 =09buf_size =3D TLS_HEADER_SIZE + cipher_desc->iv;
 =09len =3D min_t(int, *in_len, buf_size);
@@ -338,14 +332,9 @@ static struct sk_buff *tls_enc_skb(struct tls_context =
*tls_ctx,
 =09if (!aead_req)
 =09=09return NULL;
=20
-=09switch (tls_ctx->crypto_send.info.cipher_type) {
-=09case TLS_CIPHER_AES_GCM_128:
-=09case TLS_CIPHER_AES_GCM_256:
-=09=09break;
-=09default:
-=09=09goto free_req;
-=09}
 =09cipher_desc =3D get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
+=09DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
 =09buf_len =3D cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
 =09=09  sync_size + cipher_desc->tag;
 =09buf =3D kmalloc(buf_len, GFP_ATOMIC);
--=20
2.42.0


