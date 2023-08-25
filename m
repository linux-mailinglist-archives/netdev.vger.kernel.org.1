Return-Path: <netdev+bounces-30771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E876078906C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4440A281814
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664D193BE;
	Fri, 25 Aug 2023 21:35:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6A193A0
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:35:54 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D810C7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:35:53 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-m7dtteH5PAOi6CjjPXuiqg-1; Fri, 25 Aug 2023 17:35:46 -0400
X-MC-Unique: m7dtteH5PAOi6CjjPXuiqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C9CC800193;
	Fri, 25 Aug 2023 21:35:45 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3DD1678B;
	Fri, 25 Aug 2023 21:35:44 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 01/17] selftests: tls: add test variants for aria-gcm
Date: Fri, 25 Aug 2023 23:35:06 +0200
Message-Id: <ccf4a4d3f3820f8ff30431b7629f5210cb33fa89.1692977948.git.sd@queasysnail.net>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Only supported for TLS1.2.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/config |  1 +
 tools/testing/selftests/net/tls.c  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/n=
et/config
index cd3cc52c59b4..8da562a9ae87 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -51,3 +51,4 @@ CONFIG_AMT=3Dm
 CONFIG_VXLAN=3Dm
 CONFIG_IP_SCTP=3Dm
 CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
+CONFIG_CRYPTO_ARIA=3Dy
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/ne=
t/tls.c
index 4b63708c6a81..95bef2be48cd 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -36,6 +36,8 @@ struct tls_crypto_info_keys {
 =09=09struct tls12_crypto_info_sm4_ccm sm4ccm;
 =09=09struct tls12_crypto_info_aes_ccm_128 aesccm128;
 =09=09struct tls12_crypto_info_aes_gcm_256 aesgcm256;
+=09=09struct tls12_crypto_info_aria_gcm_128 ariagcm128;
+=09=09struct tls12_crypto_info_aria_gcm_256 ariagcm256;
 =09};
 =09size_t len;
 };
@@ -76,6 +78,16 @@ static void tls_crypto_info_init(uint16_t tls_version, u=
int16_t cipher_type,
 =09=09tls12->aesgcm256.info.version =3D tls_version;
 =09=09tls12->aesgcm256.info.cipher_type =3D cipher_type;
 =09=09break;
+=09case TLS_CIPHER_ARIA_GCM_128:
+=09=09tls12->len =3D sizeof(struct tls12_crypto_info_aria_gcm_128);
+=09=09tls12->ariagcm128.info.version =3D tls_version;
+=09=09tls12->ariagcm128.info.cipher_type =3D cipher_type;
+=09=09break;
+=09case TLS_CIPHER_ARIA_GCM_256:
+=09=09tls12->len =3D sizeof(struct tls12_crypto_info_aria_gcm_256);
+=09=09tls12->ariagcm256.info.version =3D tls_version;
+=09=09tls12->ariagcm256.info.cipher_type =3D cipher_type;
+=09=09break;
 =09default:
 =09=09break;
 =09}
@@ -312,6 +324,18 @@ FIXTURE_VARIANT_ADD(tls, 13_nopad)
 =09.nopad =3D true,
 };
=20
+FIXTURE_VARIANT_ADD(tls, 12_aria_gcm)
+{
+=09.tls_version =3D TLS_1_2_VERSION,
+=09.cipher_type =3D TLS_CIPHER_ARIA_GCM_128,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256)
+{
+=09.tls_version =3D TLS_1_2_VERSION,
+=09.cipher_type =3D TLS_CIPHER_ARIA_GCM_256,
+};
+
 FIXTURE_SETUP(tls)
 {
 =09struct tls_crypto_info_keys tls12;
--=20
2.40.1


