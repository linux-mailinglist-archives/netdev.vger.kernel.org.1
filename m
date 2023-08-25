Return-Path: <netdev+bounces-30772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE978906D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CFE281869
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F471988C;
	Fri, 25 Aug 2023 21:35:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178061988A
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:35:57 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952826A2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:35:55 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-uGicqjSAOhCSsyaDBUMOtA-1; Fri, 25 Aug 2023 17:35:50 -0400
X-MC-Unique: uGicqjSAOhCSsyaDBUMOtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8C0185C1A2;
	Fri, 25 Aug 2023 21:35:49 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A0841678B;
	Fri, 25 Aug 2023 21:35:48 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 02/17] selftests: tls: add getsockopt test
Date: Fri, 25 Aug 2023 23:35:07 +0200
Message-Id: <81a007ca13de9a74f4af45635d06682cdb385a54.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kernel accepts fetching either just the version and cipher type,
or exactly the per-cipher struct. Also check that getsockopt returns
what we just passed to the kernel.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/ne=
t/tls.c
index 95bef2be48cd..0da6952a047a 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -30,6 +30,7 @@ static int fips_enabled;
=20
 struct tls_crypto_info_keys {
 =09union {
+=09=09struct tls_crypto_info crypto_info;
 =09=09struct tls12_crypto_info_aes_gcm_128 aes128;
 =09=09struct tls12_crypto_info_chacha20_poly1305 chacha20;
 =09=09struct tls12_crypto_info_sm4_gcm sm4gcm;
@@ -1496,6 +1497,40 @@ TEST_F(tls, shutdown_reuse)
 =09EXPECT_EQ(errno, EISCONN);
 }
=20
+TEST_F(tls, getsockopt)
+{
+=09struct tls_crypto_info_keys expect, get;
+=09socklen_t len;
+
+=09/* get only the version/cipher */
+=09len =3D sizeof(struct tls_crypto_info);
+=09memrnd(&get, sizeof(get));
+=09EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), 0);
+=09EXPECT_EQ(len, sizeof(struct tls_crypto_info));
+=09EXPECT_EQ(get.crypto_info.version, variant->tls_version);
+=09EXPECT_EQ(get.crypto_info.cipher_type, variant->cipher_type);
+
+=09/* get the full crypto_info */
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &expec=
t);
+=09len =3D expect.len;
+=09memrnd(&get, sizeof(get));
+=09EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), 0);
+=09EXPECT_EQ(len, expect.len);
+=09EXPECT_EQ(get.crypto_info.version, variant->tls_version);
+=09EXPECT_EQ(get.crypto_info.cipher_type, variant->cipher_type);
+=09EXPECT_EQ(memcmp(&get, &expect, expect.len), 0);
+
+=09/* short get should fail */
+=09len =3D sizeof(struct tls_crypto_info) - 1;
+=09EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), -1);
+=09EXPECT_EQ(errno, EINVAL);
+
+=09/* partial get of the cipher data should fail */
+=09len =3D expect.len - 1;
+=09EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), -1);
+=09EXPECT_EQ(errno, EINVAL);
+}
+
 FIXTURE(tls_err)
 {
 =09int fd, cfd;
--=20
2.40.1


