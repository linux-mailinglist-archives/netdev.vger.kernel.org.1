Return-Path: <netdev+bounces-39305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F167BEBEB
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2483B1C2098C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0D38DD7;
	Mon,  9 Oct 2023 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94B1E503
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:06 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E79E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:04 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-sEVz35S7NQ--mfmfG4tt-Q-1; Mon, 09 Oct 2023 16:50:59 -0400
X-MC-Unique: sEVz35S7NQ--mfmfG4tt-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CFB03822E82;
	Mon,  9 Oct 2023 20:50:59 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC6936E1;
	Mon,  9 Oct 2023 20:50:57 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 01/14] tls: get salt using crypto_info_salt in tls_enc_skb
Date: Mon,  9 Oct 2023 22:50:41 +0200
Message-ID: <28557ba1f19ef9f30fd748d4febf131c88979764.1696596130.git.sd@queasysnail.net>
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

I skipped this conversion in my previous series.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_device_fallback.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 1d743f310f4f..b4a65f53d9c0 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -340,10 +340,7 @@ static struct sk_buff *tls_enc_skb(struct tls_context =
*tls_ctx,
=20
 =09switch (tls_ctx->crypto_send.info.cipher_type) {
 =09case TLS_CIPHER_AES_GCM_128:
-=09=09salt =3D tls_ctx->crypto_send.aes_gcm_128.salt;
-=09=09break;
 =09case TLS_CIPHER_AES_GCM_256:
-=09=09salt =3D tls_ctx->crypto_send.aes_gcm_256.salt;
 =09=09break;
 =09default:
 =09=09goto free_req;
@@ -356,6 +353,7 @@ static struct sk_buff *tls_enc_skb(struct tls_context *=
tls_ctx,
 =09=09goto free_req;
=20
 =09iv =3D buf;
+=09salt =3D crypto_info_salt(&tls_ctx->crypto_send.info, cipher_desc);
 =09memcpy(iv, salt, cipher_desc->salt);
 =09aad =3D buf + cipher_desc->salt + cipher_desc->iv;
 =09dummy_buf =3D aad + TLS_AAD_SPACE_SIZE;
--=20
2.42.0


