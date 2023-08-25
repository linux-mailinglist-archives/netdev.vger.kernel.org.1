Return-Path: <netdev+bounces-30781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E2789080
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450B628196B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384B198A2;
	Fri, 25 Aug 2023 21:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D5193AC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:53 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E526AD
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:51 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-uxWBkNANOsaJ4UGwrdai2w-1; Fri, 25 Aug 2023 17:36:32 -0400
X-MC-Unique: uxWBkNANOsaJ4UGwrdai2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3121F85C6E2;
	Fri, 25 Aug 2023 21:36:32 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61EA91678B;
	Fri, 25 Aug 2023 21:36:31 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 09/17] tls: validate cipher descriptions at compile time
Date: Fri, 25 Aug 2023 23:35:14 +0200
Message-Id: <b38fb8cf60e099e82ae9979c3c9c92421042417c.1692977948.git.sd@queasysnail.net>
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
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index bbdf211cc898..9d8629be7017 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -58,6 +58,15 @@ enum {
 =09TLS_NUM_PROTS,
 };
=20
+#define CHECK_CIPHER_DESC(cipher,ci)=09=09=09=09\
+=09static_assert(cipher ## _IV_SIZE <=3D MAX_IV_SIZE);=09=09\
+=09static_assert(cipher ## _REC_SEQ_SIZE <=3D TLS_MAX_REC_SEQ_SIZE);=09\
+=09static_assert(cipher ## _TAG_SIZE =3D=3D TLS_TAG_SIZE);=09=09\
+=09static_assert(sizeof_field(struct ci, iv) =3D=3D cipher ## _IV_SIZE);=
=09\
+=09static_assert(sizeof_field(struct ci, key) =3D=3D cipher ## _KEY_SIZE);=
=09\
+=09static_assert(sizeof_field(struct ci, salt) =3D=3D cipher ## _SALT_SIZE=
);=09\
+=09static_assert(sizeof_field(struct ci, rec_seq) =3D=3D cipher ## _REC_SE=
Q_SIZE);
+
 #define __CIPHER_DESC(ci) \
 =09.iv_offset =3D offsetof(struct ci, iv), \
 =09.key_offset =3D offsetof(struct ci, key), \
@@ -100,6 +109,15 @@ const struct tls_cipher_desc tls_cipher_desc[TLS_CIPHE=
R_MAX + 1 - TLS_CIPHER_MIN
 =09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256, "g=
cm(aria)", false),
 };
=20
+CHECK_CIPHER_DESC(TLS_CIPHER_AES_GCM_128, tls12_crypto_info_aes_gcm_128);
+CHECK_CIPHER_DESC(TLS_CIPHER_AES_GCM_256, tls12_crypto_info_aes_gcm_256);
+CHECK_CIPHER_DESC(TLS_CIPHER_AES_CCM_128, tls12_crypto_info_aes_ccm_128);
+CHECK_CIPHER_DESC(TLS_CIPHER_CHACHA20_POLY1305, tls12_crypto_info_chacha20=
_poly1305);
+CHECK_CIPHER_DESC(TLS_CIPHER_SM4_GCM, tls12_crypto_info_sm4_gcm);
+CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
+CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128)=
;
+CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256)=
;
+
 static const struct proto *saved_tcpv6_prot;
 static DEFINE_MUTEX(tcpv6_prot_mutex);
 static const struct proto *saved_tcpv4_prot;
--=20
2.40.1


