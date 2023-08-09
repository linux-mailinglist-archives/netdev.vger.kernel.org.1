Return-Path: <netdev+bounces-25855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FDB77601C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAFD1C211A7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195B18C21;
	Wed,  9 Aug 2023 12:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167418C16
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:59:54 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56371FFA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:59:52 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-uRtV6th5PJSm9TCk1AqRNw-1; Wed, 09 Aug 2023 08:59:34 -0400
X-MC-Unique: uRtV6th5PJSm9TCk1AqRNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BCC9185A78B;
	Wed,  9 Aug 2023 12:59:33 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDFE52166B25;
	Wed,  9 Aug 2023 12:59:31 +0000 (UTC)
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
Subject: [PATCH net-next v3 6/6] selftests: tls: add rekey tests
Date: Wed,  9 Aug 2023 14:58:55 +0200
Message-Id: <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>
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
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v2: add rekey_fail test (reject changing the version/cipher)
v3: add rekey_peek_splice (suggested by Jakub)
    add rekey+poll tests

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 450 ++++++++++++++++++++++++++++++
 1 file changed, 450 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/ne=
t/tls.c
index 8d05748a0f57..d1a50995a662 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1474,6 +1474,456 @@ TEST_F(tls, shutdown_reuse)
 =09EXPECT_EQ(errno, EISCONN);
 }
=20
+#define TLS_RECORD_TYPE_HANDSHAKE      0x16
+/* key_update, length 1, update_not_requested */
+static const char key_update_msg[] =3D "\x18\x00\x00\x01\x00";
+static void tls_send_keyupdate(struct __test_metadata *_metadata, int fd)
+{
+=09size_t len =3D sizeof(key_update_msg);
+
+=09EXPECT_EQ(tls_send_cmsg(fd, TLS_RECORD_TYPE_HANDSHAKE,
+=09=09=09=09(char *)key_update_msg, len, 0),
+=09=09  len);
+}
+
+static void tls_recv_keyupdate(struct __test_metadata *_metadata, int fd, =
int flags)
+{
+=09char buf[100];
+
+=09EXPECT_EQ(tls_recv_cmsg(_metadata, fd, TLS_RECORD_TYPE_HANDSHAKE, buf, =
sizeof(buf), flags),
+=09=09  sizeof(key_update_msg));
+=09EXPECT_EQ(memcmp(buf, key_update_msg, sizeof(key_update_msg)), 0);
+}
+
+/* set the key to 0 then 1 for RX, immediately to 1 for TX */
+TEST_F(tls_basic, rekey_rx)
+{
+=09struct tls_crypto_info_keys tls12_0, tls12_1;
+=09char const *test_str =3D "test_message";
+=09int send_len =3D strlen(test_str) + 1;
+=09char buf[20];
+=09int ret;
+
+=09if (self->notls)
+=09=09return;
+
+=09tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+=09=09=09     &tls12_0, 0);
+=09tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+=09=09=09     &tls12_1, 1);
+
+
+=09ret =3D setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_1, tls12_1.len);
+=09ASSERT_EQ(ret, 0);
+
+=09ret =3D setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_0, tls12_0.len);
+=09ASSERT_EQ(ret, 0);
+
+=09ret =3D setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_1, tls12_1.len);
+=09EXPECT_EQ(ret, 0);
+
+=09EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+}
+
+/* set the key to 0 then 1 for TX, immediately to 1 for RX */
+TEST_F(tls_basic, rekey_tx)
+{
+=09struct tls_crypto_info_keys tls12_0, tls12_1;
+=09char const *test_str =3D "test_message";
+=09int send_len =3D strlen(test_str) + 1;
+=09char buf[20];
+=09int ret;
+
+=09if (self->notls)
+=09=09return;
+
+=09tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+=09=09=09     &tls12_0, 0);
+=09tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+=09=09=09     &tls12_1, 1);
+
+
+=09ret =3D setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_0, tls12_0.len);
+=09ASSERT_EQ(ret, 0);
+
+=09ret =3D setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_1, tls12_1.len);
+=09ASSERT_EQ(ret, 0);
+
+=09ret =3D setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_1, tls12_1.len);
+=09EXPECT_EQ(ret, 0);
+
+=09EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+}
+
+TEST_F(tls, rekey)
+{
+=09char const *test_str_1 =3D "test_message_before_rekey";
+=09char const *test_str_2 =3D "test_message_after_rekey";
+=09struct tls_crypto_info_keys tls12;
+=09int send_len;
+=09char buf[100];
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09/* initial send/recv */
+=09send_len =3D strlen(test_str_1) + 1;
+=09EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09/* send after rekey */
+=09send_len =3D strlen(test_str_2) + 1;
+=09EXPECT_EQ(send(self->fd, test_str_2, send_len, 0), send_len);
+
+=09/* can't receive the KeyUpdate without a control message */
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), -1);
+
+=09/* get KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+=09/* recv blocking -> -EKEYEXPIRED */
+=09EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), 0), -1);
+=09EXPECT_EQ(errno, EKEYEXPIRED);
+
+=09/* recv non-blocking -> -EKEYEXPIRED */
+=09EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+=09EXPECT_EQ(errno, EKEYEXPIRED);
+
+=09/* update RX key */
+=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0)=
;
+
+=09/* recv after rekey */
+=09EXPECT_NE(recv(self->cfd, buf, send_len, 0), -1);
+=09EXPECT_EQ(memcmp(buf, test_str_2, send_len), 0);
+}
+
+TEST_F(tls, rekey_fail)
+{
+=09char const *test_str_1 =3D "test_message_before_rekey";
+=09char const *test_str_2 =3D "test_message_after_rekey";
+=09struct tls_crypto_info_keys tls12;
+=09int send_len;
+=09char buf[100];
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09/* initial send/recv */
+=09send_len =3D strlen(test_str_1) + 1;
+=09EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+
+=09/* successful update */
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09/* invalid update: change of version */
+=09tls_crypto_info_init(TLS_1_2_VERSION, variant->cipher_type, &tls12, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), -1)=
;
+=09EXPECT_EQ(errno, EINVAL);
+
+=09/* invalid update: change of cipher */
+=09if (variant->cipher_type =3D=3D TLS_CIPHER_AES_GCM_256)
+=09=09tls_crypto_info_init(variant->tls_version, TLS_CIPHER_CHACHA20_POLY1=
305, &tls12, 1);
+=09else
+=09=09tls_crypto_info_init(variant->tls_version, TLS_CIPHER_AES_GCM_256, &=
tls12, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), -1)=
;
+=09EXPECT_EQ(errno, EINVAL);
+
+=09/* send after rekey, the invalid updates shouldn't have an effect */
+=09send_len =3D strlen(test_str_2) + 1;
+=09EXPECT_EQ(send(self->fd, test_str_2, send_len, 0), send_len);
+
+=09/* can't receive the KeyUpdate without a control message */
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), -1);
+
+=09/* get KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+=09/* recv blocking -> -EKEYEXPIRED */
+=09EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), 0), -1);
+=09EXPECT_EQ(errno, EKEYEXPIRED);
+
+=09/* recv non-blocking -> -EKEYEXPIRED */
+=09EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+=09EXPECT_EQ(errno, EKEYEXPIRED);
+
+=09/* update RX key */
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0)=
;
+
+=09/* recv after rekey */
+=09EXPECT_NE(recv(self->cfd, buf, send_len, 0), -1);
+=09EXPECT_EQ(memcmp(buf, test_str_2, send_len), 0);
+}
+
+TEST_F(tls, rekey_peek)
+{
+=09char const *test_str_1 =3D "test_message_before_rekey";
+=09struct tls_crypto_info_keys tls12;
+=09int send_len;
+=09char buf[100];
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09send_len =3D strlen(test_str_1) + 1;
+=09EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_PEEK), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+=09/* can't receive the KeyUpdate without a control message */
+=09EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_PEEK), -1);
+
+=09/* peek KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, MSG_PEEK);
+
+=09/* get KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+=09/* update RX key */
+=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0)=
;
+}
+
+TEST_F(tls, splice_rekey)
+{
+=09int send_len =3D TLS_PAYLOAD_MAX_LEN / 2;
+=09char mem_send[TLS_PAYLOAD_MAX_LEN];
+=09char mem_recv[TLS_PAYLOAD_MAX_LEN];
+=09struct tls_crypto_info_keys tls12;
+=09int p[2];
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09memrnd(mem_send, sizeof(mem_send));
+
+=09ASSERT_GE(pipe(p), 0);
+=09EXPECT_EQ(send(self->fd, mem_send, send_len, 0), send_len);
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09EXPECT_EQ(send(self->fd, mem_send, send_len, 0), send_len);
+
+=09EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), =
send_len);
+=09EXPECT_EQ(read(p[0], mem_recv, send_len), send_len);
+=09EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
+
+=09/* can't splice the KeyUpdate */
+=09EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), =
-1);
+=09EXPECT_EQ(errno, EINVAL);
+
+=09/* peek KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, MSG_PEEK);
+
+=09/* get KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+=09/* can't splice before updating the key */
+=09EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), =
-1);
+=09EXPECT_EQ(errno, EKEYEXPIRED);
+
+=09/* update RX key */
+=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0)=
;
+
+=09EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), =
send_len);
+=09EXPECT_EQ(read(p[0], mem_recv, send_len), send_len);
+=09EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
+}
+
+TEST_F(tls, rekey_peek_splice)
+{
+=09char const *test_str_1 =3D "test_message_before_rekey";
+=09struct tls_crypto_info_keys tls12;
+=09int send_len;
+=09char buf[100];
+=09char mem_recv[TLS_PAYLOAD_MAX_LEN];
+=09int p[2];
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09ASSERT_GE(pipe(p), 0);
+
+=09send_len =3D strlen(test_str_1) + 1;
+=09EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_PEEK), send_len);
+=09EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+=09EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), =
send_len);
+=09EXPECT_EQ(read(p[0], mem_recv, send_len), send_len);
+=09EXPECT_EQ(memcmp(mem_recv, test_str_1, send_len), 0);
+}
+
+TEST_F(tls, rekey_getsockopt)
+{
+=09struct tls_crypto_info_keys tls12;
+=09struct tls_crypto_info_keys tls12_get;
+=09socklen_t len;
+
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 0);
+
+=09len =3D tls12.len;
+=09EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_get, &len), 0);
+=09EXPECT_EQ(len, tls12.len);
+=09EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+
+=09len =3D tls12.len;
+=09EXPECT_EQ(getsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_get, &len), 0);
+=09EXPECT_EQ(len, tls12.len);
+=09EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0)=
;
+
+=09len =3D tls12.len;
+=09EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_get, &len), 0);
+=09EXPECT_EQ(len, tls12.len);
+=09EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+
+=09len =3D tls12.len;
+=09EXPECT_EQ(getsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_get, &len), 0);
+=09EXPECT_EQ(len, tls12.len);
+=09EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+}
+
+TEST_F(tls, rekey_poll_pending)
+{
+=09char const *test_str =3D "test_message_after_rekey";
+=09struct tls_crypto_info_keys tls12;
+=09struct pollfd pfd =3D { };
+=09int send_len;
+=09int ret;
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09/* get KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+=09/* send immediately after rekey */
+=09send_len =3D strlen(test_str) + 1;
+=09EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+
+=09/* key hasn't been updated, expect cfd to be non-readable */
+=09pfd.fd =3D self->cfd;
+=09pfd.events =3D POLLIN;
+=09EXPECT_EQ(poll(&pfd, 1, 0), 0);
+
+=09ret =3D fork();
+=09ASSERT_GE(ret, 0);
+
+=09if (ret) {
+=09=09int pid2, status;
+
+=09=09/* wait before installing the new key */
+=09=09sleep(1);
+
+=09=09/* update RX key while poll() is sleeping */
+=09=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len),=
 0);
+
+=09=09pid2 =3D wait(&status);
+=09=09EXPECT_EQ(pid2, ret);
+=09=09EXPECT_EQ(status, 0);
+=09} else {
+=09=09pfd.fd =3D self->cfd;
+=09=09pfd.events =3D POLLIN;
+=09=09EXPECT_EQ(poll(&pfd, 1, 5000), 1);
+
+=09=09exit(!_metadata->passed);
+=09}
+}
+
+TEST_F(tls, rekey_poll_delay)
+{
+=09char const *test_str =3D "test_message_after_rekey";
+=09struct tls_crypto_info_keys tls12;
+=09struct pollfd pfd =3D { };
+=09int send_len;
+=09int ret;
+
+=09if (variant->tls_version !=3D TLS_1_3_VERSION)
+=09=09return;
+
+=09/* update TX key */
+=09tls_send_keyupdate(_metadata, self->fd);
+=09tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12=
, 1);
+=09EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+=09/* get KeyUpdate */
+=09tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+=09ret =3D fork();
+=09ASSERT_GE(ret, 0);
+
+=09if (ret) {
+=09=09int pid2, status;
+
+=09=09/* wait before installing the new key */
+=09=09sleep(1);
+
+=09=09/* update RX key while poll() is sleeping */
+=09=09EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len),=
 0);
+
+=09=09sleep(1);
+=09=09send_len =3D strlen(test_str) + 1;
+=09=09EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+
+=09=09pid2 =3D wait(&status);
+=09=09EXPECT_EQ(pid2, ret);
+=09=09EXPECT_EQ(status, 0);
+=09} else {
+=09=09pfd.fd =3D self->cfd;
+=09=09pfd.events =3D POLLIN;
+=09=09EXPECT_EQ(poll(&pfd, 1, 5000), 1);
+=09=09exit(!_metadata->passed);
+=09}
+}
+
 FIXTURE(tls_err)
 {
 =09int fd, cfd;
--=20
2.40.1


