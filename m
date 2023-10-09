Return-Path: <netdev+bounces-39310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 919B37BEBF0
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D261C20B9E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804B38DF0;
	Mon,  9 Oct 2023 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EE1F5E4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:19 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E5A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:17 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-BeNv3Q2ZPbqDmiHAbnVysg-1; Mon, 09 Oct 2023 16:51:13 -0400
X-MC-Unique: BeNv3Q2ZPbqDmiHAbnVysg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AE49803497;
	Mon,  9 Oct 2023 20:51:13 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A11436E1;
	Mon,  9 Oct 2023 20:51:12 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 12/14] tls: validate crypto_info in a separate helper
Date: Mon,  9 Oct 2023 22:50:52 +0200
Message-ID: <c46ea715e04c51d8c88125307dc9670ea65e3f58.1696596130.git.sd@queasysnail.net>
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

Simplify do_tls_setsockopt_conf a bit.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 51 ++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a342853ab6ae..b125a08a618a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -580,6 +580,31 @@ static int tls_getsockopt(struct sock *sk, int level, =
int optname,
 =09return do_tls_getsockopt(sk, optname, optval, optlen);
 }
=20
+static int validate_crypto_info(const struct tls_crypto_info *crypto_info,
+=09=09=09=09const struct tls_crypto_info *alt_crypto_info)
+{
+=09if (crypto_info->version !=3D TLS_1_2_VERSION &&
+=09    crypto_info->version !=3D TLS_1_3_VERSION)
+=09=09return -EINVAL;
+
+=09switch (crypto_info->cipher_type) {
+=09case TLS_CIPHER_ARIA_GCM_128:
+=09case TLS_CIPHER_ARIA_GCM_256:
+=09=09if (crypto_info->version !=3D TLS_1_2_VERSION)
+=09=09=09return -EINVAL;
+=09=09break;
+=09}
+
+=09/* Ensure that TLS version and ciphers are same in both directions */
+=09if (TLS_CRYPTO_INFO_READY(alt_crypto_info)) {
+=09=09if (alt_crypto_info->version !=3D crypto_info->version ||
+=09=09    alt_crypto_info->cipher_type !=3D crypto_info->cipher_type)
+=09=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
 static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 =09=09=09=09  unsigned int optlen, int tx)
 {
@@ -611,21 +636,9 @@ static int do_tls_setsockopt_conf(struct sock *sk, soc=
kptr_t optval,
 =09=09goto err_crypto_info;
 =09}
=20
-=09/* check version */
-=09if (crypto_info->version !=3D TLS_1_2_VERSION &&
-=09    crypto_info->version !=3D TLS_1_3_VERSION) {
-=09=09rc =3D -EINVAL;
+=09rc =3D validate_crypto_info(crypto_info, alt_crypto_info);
+=09if (rc)
 =09=09goto err_crypto_info;
-=09}
-
-=09/* Ensure that TLS version and ciphers are same in both directions */
-=09if (TLS_CRYPTO_INFO_READY(alt_crypto_info)) {
-=09=09if (alt_crypto_info->version !=3D crypto_info->version ||
-=09=09    alt_crypto_info->cipher_type !=3D crypto_info->cipher_type) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto err_crypto_info;
-=09=09}
-=09}
=20
 =09cipher_desc =3D get_cipher_desc(crypto_info->cipher_type);
 =09if (!cipher_desc) {
@@ -633,16 +646,6 @@ static int do_tls_setsockopt_conf(struct sock *sk, soc=
kptr_t optval,
 =09=09goto err_crypto_info;
 =09}
=20
-=09switch (crypto_info->cipher_type) {
-=09case TLS_CIPHER_ARIA_GCM_128:
-=09case TLS_CIPHER_ARIA_GCM_256:
-=09=09if (crypto_info->version !=3D TLS_1_2_VERSION) {
-=09=09=09rc =3D -EINVAL;
-=09=09=09goto err_crypto_info;
-=09=09}
-=09=09break;
-=09}
-
 =09if (optlen !=3D cipher_desc->crypto_info) {
 =09=09rc =3D -EINVAL;
 =09=09goto err_crypto_info;
--=20
2.42.0


