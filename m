Return-Path: <netdev+bounces-30778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191778907C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6549B1C21019
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2C19891;
	Fri, 25 Aug 2023 21:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A219886
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:36 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7326B0
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:35 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-mrxc8IQhOXiLXvRL0kCBFw-1; Fri, 25 Aug 2023 17:36:29 -0400
X-MC-Unique: mrxc8IQhOXiLXvRL0kCBFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28B0B8030A9;
	Fri, 25 Aug 2023 21:36:29 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 509A16B2B4;
	Fri, 25 Aug 2023 21:36:28 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 08/17] tls: extend tls_cipher_desc to fully describe the ciphers
Date: Fri, 25 Aug 2023 23:35:13 +0200
Message-Id: <39d5f476d63c171097764e8d38f6f158b7c109ae.1692977948.git.sd@queasysnail.net>
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

 - add nonce, usually equal to iv_size but not for chacha
 - add offsets into the crypto_info for each field
 - add algorithm name
 - add offloadable flag

Also add helpers to access each field of a crypto_info struct
described by a tls_cipher_desc.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h      | 32 ++++++++++++++++++++++++++++++++
 net/tls/tls_main.c | 41 ++++++++++++++++++++++++++++++++---------
 2 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index d4b56ca9d267..28a8c0e80e3c 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -52,11 +52,19 @@
 =09SNMP_DEC_STATS((net)->mib.tls_statistics, field)
=20
 struct tls_cipher_desc {
+=09unsigned int nonce;
 =09unsigned int iv;
 =09unsigned int key;
 =09unsigned int salt;
 =09unsigned int tag;
 =09unsigned int rec_seq;
+=09unsigned int iv_offset;
+=09unsigned int key_offset;
+=09unsigned int salt_offset;
+=09unsigned int rec_seq_offset;
+=09char *cipher_name;
+=09bool offloadable;
+=09size_t crypto_info;
 };
=20
 #define TLS_CIPHER_MIN TLS_CIPHER_AES_GCM_128
@@ -71,6 +79,30 @@ static inline const struct tls_cipher_desc *get_cipher_d=
esc(u16 cipher_type)
 =09return &tls_cipher_desc[cipher_type - TLS_CIPHER_MIN];
 }
=20
+static inline char *crypto_info_iv(struct tls_crypto_info *crypto_info,
+=09=09=09=09   const struct tls_cipher_desc *cipher_desc)
+{
+=09return (char *)crypto_info + cipher_desc->iv_offset;
+}
+
+static inline char *crypto_info_key(struct tls_crypto_info *crypto_info,
+=09=09=09=09    const struct tls_cipher_desc *cipher_desc)
+{
+=09return (char *)crypto_info + cipher_desc->key_offset;
+}
+
+static inline char *crypto_info_salt(struct tls_crypto_info *crypto_info,
+=09=09=09=09     const struct tls_cipher_desc *cipher_desc)
+{
+=09return (char *)crypto_info + cipher_desc->salt_offset;
+}
+
+static inline char *crypto_info_rec_seq(struct tls_crypto_info *crypto_inf=
o,
+=09=09=09=09=09const struct tls_cipher_desc *cipher_desc)
+{
+=09return (char *)crypto_info + cipher_desc->rec_seq_offset;
+}
+
=20
 /* TLS records are maintained in 'struct tls_rec'. It stores the memory pa=
ges
  * allocated or mapped for each TLS record. After encryption, the records =
are
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 217c2aa004dc..bbdf211cc898 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -58,23 +58,46 @@ enum {
 =09TLS_NUM_PROTS,
 };
=20
-#define CIPHER_DESC(cipher) [cipher - TLS_CIPHER_MIN] =3D {=09\
+#define __CIPHER_DESC(ci) \
+=09.iv_offset =3D offsetof(struct ci, iv), \
+=09.key_offset =3D offsetof(struct ci, key), \
+=09.salt_offset =3D offsetof(struct ci, salt), \
+=09.rec_seq_offset =3D offsetof(struct ci, rec_seq), \
+=09.crypto_info =3D sizeof(struct ci)
+
+#define CIPHER_DESC(cipher,ci,algname,_offloadable) [cipher - TLS_CIPHER_M=
IN] =3D {=09\
+=09.nonce =3D cipher ## _IV_SIZE, \
 =09.iv =3D cipher ## _IV_SIZE, \
 =09.key =3D cipher ## _KEY_SIZE, \
 =09.salt =3D cipher ## _SALT_SIZE, \
 =09.tag =3D cipher ## _TAG_SIZE, \
 =09.rec_seq =3D cipher ## _REC_SEQ_SIZE, \
+=09.cipher_name =3D algname,=09\
+=09.offloadable =3D _offloadable, \
+=09__CIPHER_DESC(ci), \
+}
+
+#define CIPHER_DESC_NONCE0(cipher,ci,algname,_offloadable) [cipher - TLS_C=
IPHER_MIN] =3D { \
+=09.nonce =3D 0, \
+=09.iv =3D cipher ## _IV_SIZE, \
+=09.key =3D cipher ## _KEY_SIZE, \
+=09.salt =3D cipher ## _SALT_SIZE, \
+=09.tag =3D cipher ## _TAG_SIZE, \
+=09.rec_seq =3D cipher ## _REC_SEQ_SIZE, \
+=09.cipher_name =3D algname,=09\
+=09.offloadable =3D _offloadable, \
+=09__CIPHER_DESC(ci), \
 }
=20
 const struct tls_cipher_desc tls_cipher_desc[TLS_CIPHER_MAX + 1 - TLS_CIPH=
ER_MIN] =3D {
-=09CIPHER_DESC(TLS_CIPHER_AES_GCM_128),
-=09CIPHER_DESC(TLS_CIPHER_AES_GCM_256),
-=09CIPHER_DESC(TLS_CIPHER_AES_CCM_128),
-=09CIPHER_DESC(TLS_CIPHER_CHACHA20_POLY1305),
-=09CIPHER_DESC(TLS_CIPHER_SM4_GCM),
-=09CIPHER_DESC(TLS_CIPHER_SM4_CCM),
-=09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128),
-=09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256),
+=09CIPHER_DESC(TLS_CIPHER_AES_GCM_128, tls12_crypto_info_aes_gcm_128, "gcm=
(aes)", true),
+=09CIPHER_DESC(TLS_CIPHER_AES_GCM_256, tls12_crypto_info_aes_gcm_256, "gcm=
(aes)", true),
+=09CIPHER_DESC(TLS_CIPHER_AES_CCM_128, tls12_crypto_info_aes_ccm_128, "ccm=
(aes)", false),
+=09CIPHER_DESC_NONCE0(TLS_CIPHER_CHACHA20_POLY1305, tls12_crypto_info_chac=
ha20_poly1305, "rfc7539(chacha20,poly1305)", false),
+=09CIPHER_DESC(TLS_CIPHER_SM4_GCM, tls12_crypto_info_sm4_gcm, "gcm(sm4)", =
false),
+=09CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm, "ccm(sm4)", =
false),
+=09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128, "g=
cm(aria)", false),
+=09CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256, "g=
cm(aria)", false),
 };
=20
 static const struct proto *saved_tcpv6_prot;
--=20
2.40.1


