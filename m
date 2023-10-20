Return-Path: <netdev+bounces-43035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2597D1128
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32D8B20F5C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7611CFA5;
	Fri, 20 Oct 2023 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D612E65
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:01:44 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7C93
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:01:42 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-3JsyPrCGNm-HM-QVIbN41Q-1; Fri, 20 Oct 2023 10:01:39 -0400
X-MC-Unique: 3JsyPrCGNm-HM-QVIbN41Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84EC1185A790;
	Fri, 20 Oct 2023 14:01:38 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 239102026D66;
	Fri, 20 Oct 2023 14:01:36 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Pismenny <borisp@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>
Subject: [PATCH net-next] tls: don't reset prot->aad_size and prot->tail_size for TLS_HW
Date: Fri, 20 Oct 2023 16:00:55 +0200
Message-ID: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

Prior to commit 1a074f7618e8 ("tls: also use init_prot_info in
tls_set_device_offload"), setting TLS_HW on TX didn't touch
prot->aad_size and prot->tail_size. They are set to 0 during context
allocation (tls_prot_info is embedded in tls_context, kzalloc'd by
tls_ctx_create).

When the RX key is configured, tls_set_sw_offload is called (for both
TLS_SW and TLS_HW). If the TX key is configured in TLS_HW mode after
the RX key has been installed, init_prot_info will now overwrite the
correct values of aad_size and tail_size, breaking SW decryption and
causing -EBADMSG errors to be returned to userspace.

Since TLS_HW doesn't use aad_size and tail_size at all (for TLS1.2,
tail_size is always 0, and aad_size is equal to TLS_HEADER_SIZE +
rec_seq_size), we can simply drop this hunk.

Fixes: 1a074f7618e8 ("tls: also use init_prot_info in tls_set_device_offloa=
d")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
Tariq, does that solve the problem you reported in
https://lore.kernel.org/netdev/3ace1e75-c0a5-4473-848d-91f9ac0a8f9c@gmail.c=
om/
?

 net/tls/tls.h        |  3 +--
 net/tls/tls_device.c |  2 +-
 net/tls/tls_sw.c     | 10 ++--------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 478b2c0060aa..762f424ff2d5 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -144,8 +144,7 @@ void tls_err_abort(struct sock *sk, int err);
=20
 int init_prot_info(struct tls_prot_info *prot,
 =09=09   const struct tls_crypto_info *crypto_info,
-=09=09   const struct tls_cipher_desc *cipher_desc,
-=09=09   int mode);
+=09=09   const struct tls_cipher_desc *cipher_desc);
 int tls_set_sw_offload(struct sock *sk, int tx);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f01543557a60..bf8ed36b1ad6 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1099,7 +1099,7 @@ int tls_set_device_offload(struct sock *sk)
 =09=09goto release_netdev;
 =09}
=20
-=09rc =3D init_prot_info(prot, crypto_info, cipher_desc, TLS_HW);
+=09rc =3D init_prot_info(prot, crypto_info, cipher_desc);
 =09if (rc)
 =09=09goto release_netdev;
=20
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 0f6da4ce3ed7..93747ba0d4f0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2622,8 +2622,7 @@ static struct tls_sw_context_rx *init_ctx_rx(struct t=
ls_context *ctx)
=20
 int init_prot_info(struct tls_prot_info *prot,
 =09=09   const struct tls_crypto_info *crypto_info,
-=09=09   const struct tls_cipher_desc *cipher_desc,
-=09=09   int mode)
+=09=09   const struct tls_cipher_desc *cipher_desc)
 {
 =09u16 nonce_size =3D cipher_desc->nonce;
=20
@@ -2636,11 +2635,6 @@ int init_prot_info(struct tls_prot_info *prot,
 =09=09prot->tail_size =3D 0;
 =09}
=20
-=09if (mode =3D=3D TLS_HW) {
-=09=09prot->aad_size =3D 0;
-=09=09prot->tail_size =3D 0;
-=09}
-
 =09/* Sanity-check the sizes for stack allocations. */
 =09if (nonce_size > TLS_MAX_IV_SIZE || prot->aad_size > TLS_MAX_AAD_SIZE)
 =09=09return -EINVAL;
@@ -2700,7 +2694,7 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 =09=09goto free_priv;
 =09}
=20
-=09rc =3D init_prot_info(prot, crypto_info, cipher_desc, TLS_SW);
+=09rc =3D init_prot_info(prot, crypto_info, cipher_desc);
 =09if (rc)
 =09=09goto free_priv;
=20
--=20
2.42.0


